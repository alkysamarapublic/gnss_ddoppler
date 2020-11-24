function vec = rcv_vector(h, lat, long)
% Get receiver vector
% h - altitude
% LAT - latitude
% Long - longtitude
    Re = 6.371e+6;
    %vec = kep2cart(Re+h,lat, long, pi/2);
    vec = kep2cart(Re+h, pi/2, long, lat);
    v = vec(1:3);
    v = v/norm(v);
    v = 0*v * Re*2*pi/24/3600*cos(lat);
    vec = [vec(1:3); v];
end

