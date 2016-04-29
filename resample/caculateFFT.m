function [f,fftv] = caculateFFT(im)
[x,y,z] = size(im);
s = zeros(x,y-2);
for r=1:x
    for c = 2:y-1
        s(r,c-1) = mean(2*im(r,c,:) -im(r,c+1,:)-im(r,c-1,:));
    end
end
v = sum(s,1);

fftv = fft(v,y-2);
n=0:length(fftv)-1;
f=n/length(fftv);
end