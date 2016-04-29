% 通过比较区域的ks-test 距离D来判断是否篡改
% 目前假定篡改区域在图片中心。 如果知道区域，使用ks-test准确率对于篡改过的图片预测准确率高于仅仅比较deltas是否大于40(SimpleMaxDelta_evaluation.m)
% 存在的问题：
  % 当不知道篡改区域怎么找到篡改区域？尝试过遍历然后计算每个block与剩余区域的ks距离，但是效果不好（主要是对于未篡改图片遍历的话很大的可能出现 ks距离 很大的情况），时间复杂度也很大
imgDir = dir('img');
lengthFiles = length(imgDir);
 count1=0;
 count2=0;
 total = lengthFiles-4;
 
 Result_unmapulate = zeros(lengthFiles-4,5);    %保存未篡改图片预测结果
 display('ks-test result of unmanipulated images');
 display('indexX indexY reject probability maxDistance');
for li = 5:lengthFiles
    imageName = imgDir(li).name;
    [imageName,imageDoubleCompressed,imageManipulated] = tifProcess(imageName);
    [i,j,h,p,k] = kstestOfImage(imageDoubleCompressed);
    Result_unmapulate(li-4,:) = [i,j,h,p,k];
    if k < 0.6
        count1 = count1 + 1;
    end
end
display('----ks-test result of manipulated images-----');
display('indexX indexY reject probability maxDistance');
Result_mapulate = zeros(lengthFiles-4,5);   %保存篡改图片预测结果
for li = 5:lengthFiles
    imageName = imgDir(li).name;
    [imageName,imageDoubleCompressed,imageManipulated] = tifProcess(imageName);
    [i,j,h,p,k] = kstestOfImage(imageManipulated);
    Result_mapulate(li-4,:) = [i,j,h,p,k];
    if k > 0.6
        count2 = count2 + 1;
    end
end

fprintf('unmanipulate: %f\n',count1/total);
fprintf('manipulate: %f\n',count2/total);

