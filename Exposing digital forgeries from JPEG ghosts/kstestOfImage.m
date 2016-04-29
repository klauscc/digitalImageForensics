function [i,j,h,p,k] = kstestOfImage(filename)

im = imread(filename);
checkDisplacements=0;
smoothFactor=1;

[OutputX, OutputY, dispImages,deltas,imin, Qualities]=Ghost(im, checkDisplacements, smoothFactor);


index = 15;
hwindow = 50;
[x,y] = size(deltas{index});
% bar3(deltas{15});
 i = round(x/2);
 j = round(y/2);
%  for i = 1:x-window
%     for j = 1:y-window
       partDistribution = reshape(deltas{index}(i-hwindow:i+hwindow,j-hwindow:j+hwindow),1,[]);
       restDistribution = deltas{index};
       restDistribution(i-hwindow:i+hwindow,j-hwindow:j+hwindow) = -1;
       restDistribution(restDistribution==-1) = [];
       [h,p,k] = kstest2(restDistribution,partDistribution);
%         if(k > 0.71)
          
          disp([i,j,h,p,k]);
%         end
%     end
%  end