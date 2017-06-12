
function [message_pad]=preTreated()
% generate watermark
img=imread('helloWorld.jpg');
img=img(:, :, 1);
subplot(1,4,2);
imshow(img,[]);
title('ԭʼͼ��');
[h, w, e]=size(img);

%�����븴ԭ�Ĺ�ͬ����
n=50;    %384 for 512 * 512
a=3;b=5;
N=h;

figure(1);
%����
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
%      title('�û�ͼ��');
end
message_pad = double(imgn)/255;
subplot(1, 4, 3);
imshow(message_pad);
title('����ͼ��');
imwrite(imgn, 'niceJob2.bmp');