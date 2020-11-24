%test angles
clear;
clc;

%% Constants 
Re = 6371e+3;
mu = 398600.4415e+9;

%% User defined params
%receiver
rcv_lat_delta_deg = 10;
rcv_long_deg = 0;
rcv_alt = 0;

%gnss
gnss_inc_deg = 55;
gnss_sma_km = 26560;
gnss_u_delta_deg = 1;  %step of u, deg
gnss_omega_delta_deg = 30; %step of omega, deg
gnss_frq = 1575.42e+6; %frequency


%% Calculated params

gnss_inc = gnss_inc_deg*pi/180;
gnss_sma = gnss_sma_km*1000;

gnss_omegas = gnss_omega_delta_deg*pi/180:gnss_omega_delta_deg*pi/180:2*pi;
gnss_u_delta = gnss_u_delta_deg*pi/180;
gnss_dt = gnss_u_delta*sqrt(((gnss_sma)^3)/mu); %dt=du/2pi, T=2*pi*sqrt(a^3/mu)
rcv_long = rcv_long_deg*pi/180;
rcv_lat_delta = rcv_lat_delta_deg*pi/180;
rcv_lats = (-0*pi/2:rcv_lat_delta:pi/2)';

Nr = length(rcv_lats);
No = length(gnss_omegas);
Nu = ceil(2*pi / gnss_u_delta);

%% prepare
max_ddopps = zeros(Nr, No);
min_ddopps = zeros(Nr, No);
legend_strs_min = [];
legend_strs_max = [];

%% calc

for latitude_index = 1:Nr
    rcv = rcv_vector(rcv_alt,rcv_lats(latitude_index), rcv_long);
    for omega_index=1:No
        [dopp, fus, forbit] = calc_orbit_doppler(gnss_sma,gnss_inc,gnss_omegas(omega_index),...
                                  gnss_u_delta, rcv, gnss_frq, 0, 0);
        ddopp = abs(ddopp_calc(dopp, gnss_dt));
        if ~isempty(ddopp)
            max_dd = max(ddopp);
            min_dd = min(ddopp);
        else
            max_dd = NaN;
            min_dd = NaN;
        end
        max_ddopps(latitude_index,omega_index) = max_dd;
        min_ddopps(latitude_index,omega_index) = min_dd;
    end
    legend_strs_min = [legend_strs_min; string(['lat' num2str(rcv_lats(latitude_index)*180/pi), 'min'])];
    legend_strs_max = [legend_strs_max; string(['lat' num2str(rcv_lats(latitude_index)*180/pi) 'max'])];
end

absmaxmax_ddopp = max(max(max_ddopps))
absminmax_ddopp = min(min(max_ddopps))

absmaxmin_ddopp = max(max(min_ddopps))
absminmin_ddopp = min(min(min_ddopps))

%% plots
h1 = figure(1); clf();
set(h1,'Color','White');
plot(gnss_omegas*180/pi,max_ddopps,'.-', gnss_omegas/pi*180,min_ddopps,'*-');
%plot(gnss_omegas*180/pi,max_ddopps,'.-');
grid on;
hold on;
%xlabel('Omega, deg');
%ylabel('Ddopp, Hz/s');
xlabel('Долгота восходящего узла, град');
ylabel('Скорость изменения Доплеровского смещения, Гц/с');
legend([legend_strs_max; legend_strs_min]);
%legend([legend_strs_max]);
%{
h2 = figure(2); clf();
surf(meshgrid(gnss_omegas*180/pi,[1:Nr]),180/pi*rcv_lats*ones(1,No),max_ddopps);
xlabel('Omega, deg');
ylabel('Receiver latitude, deg');
zlabel('DDopp, Hz/s');
set(h2,'Color','White');

h3 = figure(3); clf();
surf(meshgrid(gnss_omegas*180/pi,[1:Nr]),180/pi*rcv_lats*ones(1,No),min_ddopps);
xlabel('Omega, deg');
ylabel('Receiver latitude, deg');
zlabel('DDopp, Hz/s');
set(h3,'Color','White');
%}