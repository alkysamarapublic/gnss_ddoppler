% Calculate Cartesian coordinates of an orbit arc with specified parameters
% start_u
% end_u
% delta_u
% h
% omega
% inclination
function [coords us] = orbit_calc_cart(start_u, end_u, delta_u, sma, omega, inclination)
    us = (start_u:delta_u:end_u)';
    N = length(us);
    coords = zeros(6, N);
    for i=1:N
       coords(:,i) = kep2cart(sma, us(i), omega, inclination);
    end
end

