function doppler = calc_doppler(orbit,rcv, frq)
% orbit - 6element orbit data
% rcv - receiver position
% carrier frequency
    c = 299792458; %light speed
    s = size(orbit);
    n = s(2);
    doppler = zeros(n,1);
    for i=1:n
        r = orbit(1:3,i);
        v = orbit(4:6,i);
        r_rcv = rcv(1:3) - r;
        r_rcv = r_rcv/norm(r_rcv);
        v_rcv = dot(r_rcv,v+rcv(4:6));
        doppler(i) = v_rcv/c * frq;
    end
end

