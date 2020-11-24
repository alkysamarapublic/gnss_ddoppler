function ddopp = ddopp_calc(dopp, h)
    ddopp = zeros(length(dopp), 1);
    if length(dopp)<2
        return;
    end
    ddopp(1) = (dopp(2)-dopp(1))/h;
    %ddopp(1) = 0;
    for i=2:length(dopp)
        ddopp(i) = (dopp(i)-dopp(i-1))/h;
    end
    %ddopp(end) = 0;
end

