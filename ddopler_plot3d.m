function ddopler_plot3d(forbit,ddopp,figure_num)
    n = length(ddopp);
    figure(figure_num);
    hold on;
    for i=1:n
        r = ddopp(i) * forbit(1:3,i) / norm(forbit(1:3,i));
        plot3([0 r(1)],[0 r(2)],[0 r(3)],'.-b');
    end
end

