function [images] = img_postdeal(images)
%ͼ�����
%   �˴���ʾ��ϸ˵��
% ԭ���ǣ�
% images = (images - prctile(images, 1,'all')) ./ (prctile(images, 99,'all') - prctile(images, 1,'all') + eps);
% ����prctile(images, 1,'all')��2017a�汾��û�У���ʹ��prctile(images(:), 1)���
images = (images - prctile(images(:), 1)) ./ (prctile(images(:), 99) - prctile(images(:), 1) + eps);
images(images > 1) = 1;
images(images < 0) = 0;
% images = images .^ (1/2.2); %����ʲ���gamma����
end

