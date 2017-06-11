%LSBˮӡ��ȡ�㷨
clear;
clc;
m=imread('mysecret.bmp');
c=imread('lsb_watermarked.bmp');
[Mm,Nm]=size(m);	  %ȷ��ˮӡͼ��Ĵ�С
[Mc,Nc]=size(c);	  %ȷ������ͼ��Ĵ�С
x = ones(Mm,Nm,'uint8');  %Ԥ������ȡͼ��ռ�
cx = 1;
cy = 1;
for i=1:Mm
    for j=1:Nm
        for t = 1:8
            x(i,j)=bitset(x(i,j),t,bitget(c(cx,cy),1));
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

figure;
imshow(x,[]);
imwrite(x,'temp.bmp','bmp');
title('Recovered Watermark');