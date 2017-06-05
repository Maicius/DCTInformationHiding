clear all;close all;clc;

img=imread('lena.jpg');
subplot(1,3,1);
imshow(img,[]);
title('原始图像');
[h, w, e]=size(img);

%置乱与复原的共同参数
n=384;    %384 for 512 * 512
a=3;b=5;
N=h;

figure(1);
%置乱
imgn=zeros(h,w);
for i=1:n
    i
    for y=1:h
        for x=1:w           
            xx=mod((x-1)+b*(y-1),N)+1;
            yy=mod(a*(x-1)+(a*b+1)*(y-1),N)+1;        
            imgn(yy,xx)=img(y,x);                
        end
    end
    img=imgn;    
%     imshow(imgn,[]);
%     
%      % pause(0.001);
%      title('置换图像');
end
imgn = double(imgn)/255;
subplot(1, 3, 2);
imshow(imgn);
title('置乱图像');
imwrite(imgn, 'test.jpg');

% DCT变换
[count,msg,data]=hidedctadv0('test.jpg','1.jpg','1.txt',1982,0.1);
subplot(1,3,3); 
imshow(data);
title('隐藏后的图片');
imwrite(data, 'final.jpg');