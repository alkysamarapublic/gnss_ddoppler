clear;
clc;
close all;

delta = 45; %maximum phase change, deg
delta_rad = delta*pi/180;

dphi_F = @(nu_dot, t) pi*nu_dot*t^2; %rad
maxT_F = @(nu_dot) sqrt(delta_rad./(pi*nu_dot));

nu_dot = 0.005:0.02:1; %Hz/s
%omega_dot = 2*pi*nu_dot;
tmax = maxT_F(nu_dot(1));
dphimax = dphi_F(nu_dot(1),tmax);
dt = tmax / 100;
ts = 0:dt:tmax;

lent = length(ts);
len = length(nu_dot);

phis = zeros(len,lent);
tmaxs = zeros(len);
strs = [];

for i=1:len
    for j=1:lent
        dphi = dphi_F(nu_dot(i),ts(j));
        if dphi<delta_rad
            phis(i,j) = dphi;
        else
            tm = maxT_F(nu_dot(i));
            phis(i,j) = dphi_F(nu_dot(i), tm);
        end
    end
    strs = [strs; sprintf('%.2f Hz/s',nu_dot(i))];
end
figure();
plot(ts,phis*180/pi,'-');
hold on;
plot(ts,ones(1,lent)*dphimax*180/pi,'r-','LineWidth',3);
xlabel('Time,s');
ylabel('Phase difference, deg');
set(gcf,'Color','w');
legend(strs);
grid on;

figure();
plot(nu_dot,maxT_F(nu_dot),'-b');
xlabel('Frequency change rate, Hs/s');
ylabel('Guaranteed divergence time, s');
grid on;
set(gcf,'Color','w');
