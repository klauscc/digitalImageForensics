function factor = findResampleFactor( fftv )
%return the peak in the fftv,and return 1/peak, which is the resample factor
block = 3;  %一块为3个点
rate = 5;  %比邻近的块大5倍

fftvLength = length(fftv);
absFftv = abs(fftv);
factor(1) = 0;

j=0;
for i = 5:fftvLength-5
    
    currentAverageMagnitude = mean(absFftv(i:i+block-1));
    nearingAverageMagnitude = (mean(absFftv(i-block:i-1))+mean(absFftv(i+block:i+2*block-1)))/2;
    if (currentAverageMagnitude > nearingAverageMagnitude*rate)
        currentFactor = fftvLength/i;
        if j > 0 && abs(currentFactor-factor(j)) < 0.1
            continue;
        else
            j=j+1;
            factor(j) = currentFactor;
        end
    end
    
end

end

