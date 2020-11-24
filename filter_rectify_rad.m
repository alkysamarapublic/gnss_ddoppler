function [ar1_new] = filter_rectify_rad(ar1)
    index = 1;
    for i=3:length(ar1)
        if ar1(i)-ar1(i-1)<0
            index = i-1;
            break
        end
    end
    if ~isempty(ar1)>0
        if (index ~= 1)
            ar1_new = [ar1(1:index)-2*pi; ar1(index+1:end)];
        else
            ar1_new = ar1;
        end
    else
        ar1_new = [];
    end
end

