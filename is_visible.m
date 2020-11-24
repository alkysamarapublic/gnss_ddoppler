function res = is_visible(sat,rcv)
    res = dot(sat-rcv(1:3),rcv(1:3)) > 0;
end

