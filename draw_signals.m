function draw_signals(orbit,rcv)
    s = size(orbit);
    for i=1:s(2)
        plot3([orbit(1,i) rcv(1)],[orbit(2,i) rcv(2)],[orbit(3,i) rcv(3)], '.-r');
    end
    for i=1:s(2)
        r=norm(orbit(1:3,i)-rcv(1:3));
        v1 = r*orbit(4:6,i)/norm(orbit(4:6,i));
        %plot3([orbit(1,i) orbit(1,i)+v1(1)],[orbit(2,i) orbit(2,i)+v1(2)],[orbit(3,i) orbit(3,i)+v1(3)], '.-g');
    end
end

