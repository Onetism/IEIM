close all;
clear all;
clc;

addpath('./utils/');

filePath = './datasets/Real/dynamic/800Hz/9mW/output.hdf5';
[fileFolder, sampleName, ext] = fileparts(filePath);

info = h5info(filePath, '/CD/events');
datasetSize = info.Dataspace.Size;  % Get the size of the dataset

% You can set to start from the first data point and read only N points
start = 12000000;  %  Start reading points
count = 1000000;  % Read the N data points
data = h5read(filePath, '/CD/events',start,count);
data.x = data.x + 1;
data.y = data.y + 1;
disp([min(data.x), max(data.x)]);
disp([min(data.y), max(data.y)]);
data.t = data.t - min(data.t)+1;

dt = 10; % dt=1 means 1us;
savetime = max(data.t)/dt; % 1*10^6/dt means 1s;
width = 1280;
height = 720;
time = ceil(single(max(data.t))/dt) ;
data_frame = int16( zeros(height, width, time) );
t = int64(ceil(single(data.t)/dt) );

data.p(data.p == 0) = 0;

temp = int64(data.y) + (int64(data.x)-1)*height + (t-1)*height*width;
data_frame(temp)= data.p;

spikeseq = uint8(data_frame);
intervals = spike2intv(spikeseq);
image = reconstruction_isi(spikeseq, intervals);
image = flipud(uint16(mat2gray(image)*65535));

options.overwrite = true;
saveastiff(image(:,:,1:savetime), [fileFolder '/IEI_Recon.tif'], options);
    

