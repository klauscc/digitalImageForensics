fileName = 'test.jpg';
 
resizeTimes = 2.8;
im = imread(fileName);
im2 = imresize(im,resizeTimes);     %重采样，图片放大resizeTimes倍
[f1,fftv1]=caculateFFT(im);
[f2,fftv2]=caculateFFT(im2);

NumSubIms=2*2; %+1 for the plot, +1 for orig
rowsSubIms=ceil(sqrt(NumSubIms));
colsSubIms=ceil(NumSubIms/rowsSubIms);

disp('resample Factors of original image:');
disp(findResampleFactor(fftv1));
fprintf('resample Factors of image %f times resize:\r\n',resizeTimes);
disp(findResampleFactor(fftv2));

%  fig_handle=figure;
%  set(fig_handle, 'Position', [10, 10, 400*rowsSubIms, 400*colsSubIms]);
%  
 subplot(rowsSubIms,colsSubIms,1);
 image(im);
  title('原图A');
 subplot(rowsSubIms,colsSubIms,2);
 plot(f1,abs(fftv1));
 axis([0,1,0,max(abs(fftv1))*1.1]);
   title('A fft');
subplot(rowsSubIms,colsSubIms,3);
image(im2);
title2 = ['原图的',num2str(resizeTimes),'倍图B'];
title(title2);
subplot(rowsSubIms,colsSubIms,4);
 plot(f2,abs(fftv2));
 axis([0,1,0,max(abs(fftv2))*1.1]);
title('B fft ');
