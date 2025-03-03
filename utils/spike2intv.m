function intervals = spike2intv(spikeseq)
%convert spike sequence to interval sequence
[h, w, maxt] = size(spikeseq);
intervals = ones(h, w, maxt) .* inf;
for i = 1:h
    fprintf('spike2intv: %d/%d\n', i,h)
    for j = 1:w
        spike_time = find(spikeseq(i,j,:));
        intv = spike_time(2:end) - spike_time(1:end-1);
        for k = 1:numel(intv)
            if k > 1 && k < numel(intv) && intv(k-1) == intv(k+1) % correct error interval(optional)
                intv(k) = intv(k-1);
            end
            intervals(i,j,spike_time(k): spike_time(k+1) - 1) = intv(k);            
        end
    end
end
end

