clear;
clc;
c=imread('lena.bmp');     %读入载体图像
m=imread('mysecret.bmp');     %读入水印图像
[Mm,Nm]=size(m);	  %确定水印图像的大小
[Mc,Nc]=size(c);	  %确定载体图像的大小
cx = 1;
cy = 1;
for i=1:Mm
    for j=1:Nm
        for t = 1:8
            c(cx,cy)=bitset(c(cx,cy),1,bitget(m(i,j),t));
            cy = cy + 1;
            cy = mod(cy,Nc);
            if cy == 0         %载体横座标移动到行末
               cy = Nc;
            end
            if cy == 1         %载体换行
               cx = cx + 1;
            end
        end
    end
end
imwrite(c,'lsb_watermarked.bmp','bmp');
figure;  
imshow(c,[]);
title('Watermarked Image');
