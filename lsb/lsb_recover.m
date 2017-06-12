%LSB水印提取算法
clear;
clc;
m=imread('mysecret.bmp');
c=imread('lsb_watermarked.bmp');
[Mm,Nm]=size(m);	  %确定水印图像的大小
[Mc,Nc]=size(c);	  %确定载体图像的大小
x = ones(Mm,Nm,'uint8');  %预分配提取图像空间
cx = 1;
cy = 1;
for i=1:Mm
    for j=1:Nm
        for t = 1:8
            x(i,j)=bitset(x(i,j),t,bitget(c(cx,cy),1));
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

figure;
imshow(x,[]);
imwrite(x,'temp.bmp','bmp');
title('Recovered Watermark');