% 处理tif图片，生成一个仅压缩(压缩过两次)的jpeg,和一个中间区域被篡改(中间区域仅压缩过一次)的jpeg
% function tifProcess
% % process all the image in the folder 'img'
% imgDir = dir('img');jin'ya'suo
% lengthFiles = length(imgDir);
%  count1=0;
%  count2=0;
%  total = lengthFiles-4;
%  
%  for li = 5:lengthFiles
%      imageName = imgDir(li).name;
%      process(imageName);
%  end


function [imageName,imageDoubleCompressed,imageManipulated] = tifProcess(imageName)
%imageName: the name of the tif image
%imageDoubleCompressed: file path,double compressed of the tif image
%imageManipulated: manipulated image file path
imageDoubleCompressed= ['img/compressed/',imageName,'.jpg'];
imageSplitedName = 'tmpBlock.jpg';
imageManipulated = ['img/manipulate/',imageName,'.manipulated.jpg'];
imageName = ['img/',imageName];
block = 100;    %篡改的大小 block*block

im = imread(imageName); %读入原图片
[x,y,z] = size(im);     

halfX = round(x/2); %图片中间x
halfY = round(y/2); %图片中间y
halfBlock = block/2; 

%将中间block*block大小的部分取出
splitBlock = im(halfX-halfBlock:halfX+halfBlock,halfY-halfBlock:halfY+halfBlock,:);
%将原图片用65的质量压缩
imwrite(im,imageSplitedName,'JPEG','Quality',65);
%读取压缩后的图片
im = imread(imageSplitedName);
imwrite(im,imageDoubleCompressed,'JPEG','Quality',85);
%插入到原图片对应的部分
 im(halfX-halfBlock:halfX+halfBlock,halfY-halfBlock:halfY+halfBlock,:)=splitBlock;
%将原图片用85的质量压缩
imwrite(im,imageManipulated,'JPEG','Quality',85);
