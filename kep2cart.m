function [rv] = kep2cart(sma, u, omega, i)
% Convert Kplerian elements to Cartesian coordinates
% h - altitude abovw spherical Earth model
% u - argument of latitude
% omega - RAAN (right ascension of the ascending node)
% i - inclination
% @ V.I. Dudarev. TRANSFORMATION OF THE BASIC COORDINATES SYSTEMS APPLIED IN THE
% SPACE GEODESY
Re = 6.371e+6;
mu = 398600.4415e+9;
r = (sma)*[cos(u)*cos(omega)-sin(u)*sin(omega)*cos(i);
            cos(u)*sin(omega)+sin(u)*cos(omega)*cos(i);
            sin(u)*sin(i)];
v = sqrt(mu/(sma))*[-sin(u)*cos(omega)-cos(u)*sin(omega)*cos(i);...
                     -sin(u)*sin(omega)+cos(u)*cos(omega)*cos(i);
                     cos(u)*sin(i)];
rv = [r;v];
end

