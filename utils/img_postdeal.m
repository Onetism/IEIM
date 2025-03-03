function [images] = img_postdeal(images)
%图像后处理
%   此处显示详细说明
% 原句是：
% images = (images - prctile(images, 1,'all')) ./ (prctile(images, 99,'all') - prctile(images, 1,'all') + eps);
% 但是prctile(images, 1,'all')在2017a版本中没有，故使用prctile(images(:), 1)替代
images = (images - prctile(images(:), 1)) ./ (prctile(images(:), 99) - prctile(images(:), 1) + eps);
images(images > 1) = 1;
images(images < 0) = 0;
% images = images .^ (1/2.2); %大概率不开gamma矫正
end

