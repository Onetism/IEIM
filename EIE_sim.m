close all;
clear all;
clc;

addpath('./utils/');

filepath = './datasets/Synthetic/interp_CodedIllumination_evaluation_static/';
filelist = dir ([filepath '*.txt']);
for i = 1 : size(filelist,1)
    filename = [filepath  filelist(i).name];
    [~, sampleName, ext] = fileparts(filename);

    fileID = fopen(filename, 'r');
    
    size_data = fscanf(fileID, '%d %d', 2);
    width = size_data(1);
    height = size_data(2);
    
    formatSpec = '%d %d %d %d';
    event_data = fscanf(fileID, formatSpec, [4 5000000])';
    fclose(fileID);
    
    data.x = event_data(:, 2) + 1; 
    data.y = event_data(:, 3) + 1;
    data.t = event_data(:, 1);     
    data.p = event_data(:, 4);     
    
    disp(['Min X: ', num2str(min(data.x)), ', Max X: ', num2str(max(data.x))]);
    disp(['Min Y: ', num2str(min(data.y)), ', Max Y: ', num2str(max(data.y))]);
   
    
    dt = 50; % dt=1 means 1us;
    savetime = max(data.t)/dt; % 1*10^6/dt means 1s;
    time = ceil(single(max(data.t))/dt) ;
    data_frame = int16( zeros(height, width, time) );
    t = int64(ceil(single(data.t)/dt) );
    
    data.p(data.p == 0) = 0;
    
    temp = int64(data.y) + (int64(data.x)-1)*height + (t-1)*height*width;
    data_frame(temp)= data.p;
    
    spikeseq = uint8(data_frame);
    intervals = spike2intv(spikeseq);
    
    image = reconstruction_isi(spikeseq, intervals);
    image = flipud(uint16(mat2gray(image)*255));
    
    options.overwrite = true;
    saveastiff(image(:,:,1:savetime), [filepath sampleName '/IEI_Recon.tif'], options);
          
end
