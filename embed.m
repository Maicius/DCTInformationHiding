
function [Y_waterMarked]=embed(Img,row,column,blocksize,message_pad)
l=1;
k=1;
blockno=row/blocksize;

Alpha1=0.025;
Alpha2=0.1;
T1=3;
block = 8;
D=zeros(row,column);
BW=zeros(row,column);
block_dct1=zeros(8,8);
InfoSize = length(message_pad);
array=zeros(1,InfoSize*8);
for m=1:InfoSize
    Infochar=double(message_pad(m));  %% 'c'为99
    for n=1:8
        array(8*(m-1)+n)=bitget(Infochar,n);%%获得Infochar第n位的值
    end
end
plot(array);
title('原始水印信息');
for m=1:blockno
    for n=1:blockno
        x=(m-1)*block+1;   y=(n-1)*block+1;%算出每格图像的坐标（x,y）,block=8,8*8的图像小格
        block_dct1=Img(x:x+block-1,y:y+block-1);%取原始图像小格中的像素点到block_dct1矩阵中。
        block_dct1=dct2(block_dct1);%对二维数组进行离散余弦变换。dct是有损压缩如jpeg使用的技术。Dct是可逆的运算
        BW_8_8=BW(x:x+block-1,y:y+block-1);%得到边界矩阵。
        if m<=1||n<=1
            T=0;
        else
            T=sum(BW_8_8);   T=sum(T);
        end
       if T>T1  %T1=3，代表边缘点阈值， 载体图像的只在边缘较多的部分(高频)嵌入水印
            Alpha=Alpha2;
            %block_dct1(1,1)=block_dct1(1,1)*(1+Alpha*mark(k));
            if l<=(InfoStrSize*8)
                block_dct1(1,1)=block_dct1(1,1)*(1+Alpha*array(l));
                l=l+1;
            end
        else
            Alpha=Alpha1;
            % block_dct1(1,1)=block_dct1(1,1)*(1+Alpha*mark(k));  %载体图像的非边缘部分不嵌入水印
        end
        Block_dct=idct2(block_dct1);
        D(x:x+block-1,y:y+block-1)=Block_dct;
        k=k+1;
    end
end

Y_waterMarked=imread('lena.bmp');
[m,n] = size(D);
Y_waterMarked(1:m,1:n) = D(:,:);    %将嵌入的水印写入到完整的图像中