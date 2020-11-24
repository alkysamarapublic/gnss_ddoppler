%test angles
clear;
clc;

%% Constants 
Re = 6371e+3;
mu = 398600.4415e+9;

%% User defined params
%receiver
rcv_lat_deg = 45;
rcv_long_deg = 0;
rcv_alt = 0;

%gnss
gnss_inc_deg = 55; %inclination
gnss_sma_km = 26560; %altitude
gnss_u_delta_deg = 0.1;  %step of u, deg
gnss_omega_deg = 0; %step of omega, deg
gnss_frq = 1575.42e+6; %frequency, L1


%% Calculated params

gnss_inc = gnss_inc_deg*pi/180;
gnss_sma = gnss_sma_km*1000;

gnss_omega = gnss_omega_deg*pi/180;
gnss_u_delta = gnss_u_delta_deg*pi/180;
%dt corresponding to du
gnss_dt = gnss_u_delta*sqrt(((gnss_sma)^3)/mu); %dt=du/2pi, T=2*pi*sqrt(a^3/mu)
rcv_long = rcv_long_deg*pi/180;
rcv_lat = rcv_lat_deg*pi/180;

Nu = ceil(2*pi / gnss_u_delta);

%% prepare
figure(1);
clf;
draw_earth();
axis equal
hold on;


%% calc
rcv = rcv_vector(rcv_alt,rcv_lat, rcv_long);
[dopp, fus, forbit] = calc_orbit_doppler(gnss_sma,gnss_inc,gnss_omega,...
                                  gnss_u_delta, rcv, gnss_frq, 1, 0);
ddopp = abs(ddopp_calc(dopp, gnss_dt));
fusf = filter_rectify_rad(fus);
%% plots
plot3(rcv(1),rcv(2),rcv(3),'r*');
set(gcf,'Color','w');

figure(3);
plot(fusf*180/pi,ddopp,'-b');
xlabel('Argument of latitude, deg');
ylabel('Doppler change rate, Hz/s');
grid on;
set(gcf,'Color','w');

figure(4);
plot(fusf*180/pi,dopp,'-b');
xlabel('Argument of latitude, deg');
ylabel('Doppler frequency, Hz');
grid on;
set(gcf,'Color','w');