% 仅仅通过比较最大距离来判断是否篡改
% 计算发现，未被篡改的图片的最大距离几乎100%小于 40(300张图片，均是97%以上准确率),  而被篡改的图片篡改区域越大，最大距离大于40的可能就越大.
% 篡改区域100*100,96%大于40， 篡改区域50*50, 89%大于40(300张图片)
imgDir = dir('img');    %存放测试图片的文件夹
lengthFiles = length(imgDir);
 count1=0;  %未被篡改的图片预测准确个数
 count2=0;  %被篡改的图片预测准确个数
 total = lengthFiles-4;
 
 checkDisplacements=0;
 smoothFactor=1;
 
 for li = 5:lengthFiles  %预测未篡改图片
    imageName = imgDir(li).name;
    unmanipulatedFile = ['img/compressed/',imageName,'.jpg'];
    if ~exist(unmanipulatedFile,'file')
        tifprocess(imageName);
    end
    unmanipulatedIm = imread(unmanipulatedFile);
    
    [OutputX, OutputY, dispImages,deltas,imin, Qualities]=Ghost(unmanipulatedIm, checkDisplacements, smoothFactor);
    maxDeltas = max(max(deltas{15}));
    disp(maxDeltas);
    if maxDeltas < 40;
        count1 = count1 + 1;
    end
 end

 disp('manipulate-----');
  for li = 5:lengthFiles  %预测篡改图片
    imageName = imgDir(li).name;
    manipulatedFile = ['img/manipulate/',imageName,'.manipulated.jpg'];
    manipulatedIm = imread(manipulatedFile);

    [OutputX, OutputY, dispImages,deltas,imin, Qualities]=Ghost(manipulatedIm, checkDisplacements, smoothFactor);
    maxDeltas = max(max(deltas{15}));
    disp(maxDeltas);
    if maxDeltas > 40;
        count2 = count2 + 1;
    end
  end
fprintf('unmanipulate accuracy: %f\n',count1/total);
fprintf('manipulate accuracy: %f\n',count2/total);