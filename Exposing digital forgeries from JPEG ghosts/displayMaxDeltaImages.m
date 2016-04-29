% 画出 压缩质量--偏差 图，并画出极小值对应的质量的图片
filename='img/manipulate/ucid00002.tif.manipulated.jpg';
%     filename='img/compressed/ucid00002.tif.jpg';
checkDisplacements=0;
smoothFactor=1;



[OutputX, OutputY, dispImages,deltas,imin, Qualities]=Ghost(im, checkDisplacements, smoothFactor);


NumSubIms=length(imin)+2; %+1 for the plot, +1 for orig
rowsSubIms=ceil(sqrt(NumSubIms));
colsSubIms=ceil(NumSubIms/rowsSubIms);


 fig_handle=figure;
 set(fig_handle, 'Position', [10, 10, 400*rowsSubIms, 400*colsSubIms]);
 
 subplot(rowsSubIms,colsSubIms,1);
 image(im);
 
 subplot(rowsSubIms,colsSubIms,2);
 plot(OutputX,OutputY)
 axis([min(OutputX) max(OutputX) 0 max(OutputY)*1.1]);
 
 
 for ii=1:length(imin)
     subplot(rowsSubIms,colsSubIms,ii+2);
     image(round(dispImages{imin(ii)}*63));
     title(Qualities(ii));
     
 end
figure(2);
bar3(deltas{15});

