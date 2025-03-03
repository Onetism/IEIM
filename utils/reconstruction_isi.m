function images = reconstruction_isi(spikeseq, isi)
w=size(spikeseq, 2);%400; % modified by BoXiong 2022-07-24
h=size(spikeseq, 1);%250; % modified by BoXiong 2022-07-24
tnum=size(spikeseq, 3);
images = zeros(size(spikeseq));
for i = 1:h
    for j = 1:w
        spike_time = [find(spikeseq(i, j, :)); size(spikeseq, 3) + 1];
        rho_isi = zeros(1, tnum);
        for k = 1:length(spike_time) - 1
            rho_isi(spike_time(k) : spike_time(k+1) - 1) = 1 / isi(i, j, spike_time(k));
        end
        images(i,j,:) = rho_isi;
    end
    fprintf('i:%d\n', i)
end

for t = 1:tnum
    images(:,:,t) = flipdim(images(:,:,t), 1);
end
% images = (images - min(images,[],'all')) ./ (max(images,[],'all') - min(images,[],'all'));
% images = images .^ (1/2.2);