clear;
clc;
c=imread('lena.bmp');     %��������ͼ��
m=imread('mysecret.bmp');     %����ˮӡͼ��
[Mm,Nm]=size(m);	  %ȷ��ˮӡͼ��Ĵ�С
[Mc,Nc]=size(c);	  %ȷ������ͼ��Ĵ�С
cx = 1;
cy = 1;
for i=1:Mm
    for j=1:Nm
        for t = 1:8
            c(cx,cy)=bitset(c(cx,cy),1,bitget(m(i,j),t));
            cy = cy + 1;
            cy = mod(cy,Nc);
            if cy == 0         %����������ƶ�����ĩ
               cy = Nc;
            end
            if cy == 1         %���廻��
               cx = cx + 1;
            end
        end
    end
end
imwrite(c,'lsb_watermarked.bmp','bmp');
figure;  
imshow(c,[]);
title('Watermarked Image');
