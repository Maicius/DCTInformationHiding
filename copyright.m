
function [message_pad,messageEmbed]=copyright(number_blocks)
% generate watermark
img=imread('hello64.bmp');
img=img(:, :, 1);
subplot(1,4,2);
imshow(img,[]);
title('原始图像');
[h, w, e]=size(img);

%置乱与复原的共同参数
n=50;    %384 for 512 * 512
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
message_embed = double(imgn)/255;
subplot(1, 4, 3);
imshow(message_embed);
title('置乱图像');
imwrite(imgn, 'niceJob2.bmp');
% message_embed=uint8(fix(double(message)./128));     %将商标图变为0、1二值

columnRow=size(message_embed);%商标的垂直水平像素数
row=columnRow(1,1);
column=columnRow(1,2);

messageEmbed=reshape(message_embed,[1,row*column]);%将商标比特按照块数多少排列进行嵌入
messageembed=[messageEmbed,messageEmbed];
message_pad=messageembed(1:number_blocks);
