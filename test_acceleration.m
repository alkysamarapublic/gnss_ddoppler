clear;
clc;
close all;

delta = 45; %maximum phase change, deg
gnss_frq = 1575.42e+6; %frequency, L1
c = 299792458; %light speed
max_ddopp = 0.937;

delta_rad = delta*pi/180;

dphi_F = @(nu_dot, t) pi*nu_dot*t^2; %rad
nu_dot_F = @(accel) accel*gnss_frq/c;
maxT_F = @(accel) sqrt(delta_rad./(pi*(nu_dot_F(accel) + max_ddopp)));

accels = 0:0.1:3; %m/s^2

times = maxT_F(accels);

plot(accels, times,'b');
%xlabel('Acceleration, m/s^2');
%ylabel('Divergence time, s');
xlabel('Ускорение, м/с^2');
ylabel('Время расхождения, с');
grid on;
set(gcf,'Color','w');
