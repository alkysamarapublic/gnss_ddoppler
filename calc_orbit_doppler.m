function [dopp, fus, forbit] = calc_orbit_doppler(sma,inc,omega,delta_u, rcv, frq, plot3d, plot2d)
    %h,inc,omega - orbit params
    %delta_u - u step
    %rcv - receiver position
    %plot3d, plot2d - numbers of figures for plots. 0 - do not draw
    
    [orbit, us] = orbit_calc_cart(delta_u, 2*pi, delta_u, sma, omega, inc);
    [forbit, fus] = filter_visible_orbit(orbit, rcv, us);
    dopp = calc_doppler(forbit,rcv, frq);
    if (plot3d>0)
        figure(plot3d);
        draw_orbit(orbit);
        draw_signals(forbit,rcv);
    end
    if (plot2d > 0)
        figure(plot2d);
        plot(fus,dopp,'r.-');
    end
end

