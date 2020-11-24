function [filtered, fus] = filter_visible_orbit(orbit,rcv,us)
    % orbit - 3-6xXX orbit data
    % rcv - receiver coordinates
    % us - U array
    %There can be one or two visible sat. traces (because orbit begin is
    %not synchronized with receiver. We expect two traces to be in 1st half
    %and in the second => it's actually one trace, output it: [second
    %first]
    s = size(orbit);
    for i=1:s(2)
        if is_visible(orbit(1:3,i),rcv)
            start_index = i;
            break;
        end
    end
    if ~exist('start_index') % no visible points - empty output
        filtered = [];
        fus = [];
        return;
    end
    for i=start_index+1:s(2) %find end of visible trace
        if ~is_visible(orbit(1:3,i),rcv)
            end_index = i-1;
            break;
        end
    end
    if ~exist('end_index') %end == end of orbit, no other trace is possible
        filtered = orbit(1:6,start_index:end);
        fus = us(start_index:end);
        return;
    end
    
    for i=end_index+1:s(2) %search for other possible visible traces
        if is_visible(orbit(1:3,i),rcv)
            start_index1 = i;
            break;
        end
    end
    
    if ~exist('start_index1') %no other traces, output only 1st
        filtered = orbit(1:6,start_index:end_index);
        fus = us(start_index:end_index);
        return;
    end
    
    for i=start_index1+1:s(2) %found 2nd trace, search for its end
        if ~is_visible(orbit(1:3,i),rcv)
            end_index1 = i-1;
            break;
        end
    end
    if ~exist('end_index1') %second trace is till the end
        filtered = orbit(1:6,[start_index1:end start_index:end_index]);
        fus = [us([start_index1:end]); us([start_index:end_index])];
        return;
    end
    filtered = orbit(1:6,[start_index1:end_index1 start_index:end_index]);
    fus = [us([start_index1:end_index1]); us([start_index:end_index])];
end

