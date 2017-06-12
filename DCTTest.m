clear;
clc;
s=256;      %s
block=8;
blockno=s/block;%一行有32格
% LENGTH=s*s/64;
Alpha1=0.025;
Alpha2=0.1;
T1=3;
I=zeros(s,s);%产生全矩阵
D=zeros(s,s);
BW=zeros(s,s);
Block_dct1=zeros(block,block);
%产生水印，并显示水印信息；
subplot(3,2,1);
<<<<<<< HEAD
Info = imread('hello64.bmp');
info=Info(:, :, 1);

=======
Info='abc';
>>>>>>> master
InfoStrSize=length(Info);
%将字符串转换为位数组
array=zeros(1,InfoStrSize*8);
for m=1:InfoStrSize
    Infochar=double(Info(m));  %% 'c'为99
    for n=1:8
        array(8*(m-1)+n)=bitget(Infochar,n);%%获得Infochar第n位的值
    end
end
plot(array);
title('原始水印信息');

%显示原图
subplot(3,2,2);
i=imread('lena.bmp');
imshow(i,[]);
title('原始图像')

%显示prewitt为算子的边缘图  在函数检测到边缘的地方为1，其他地方为0
BW=edge(i,'prewitt');      %自动选择阈值用prewitt算子进行边缘检测。
%BW=edge(I,’Roberts’);
%BW=edge(I,’Sobel’);
%BW=edge(I,’zerocross’);
subplot(3,2,3);imshow(BW);
title('原始图像边缘图');


%嵌入水印
l=1;
k=1;
for m=1:blockno
    for n=1:blockno
        x=(m-1)*block+1;   y=(n-1)*block+1;%算出每格图像的坐标（x,y）,block=8,8*8的图像小格
        block_dct1=i(x:x+block-1,y:y+block-1);%取原始图像小格中的像素点到block_dct1矩阵中。
        block_dct1=dct2(block_dct1);%对二维数组进行离散余弦变换。dct是有损压缩如jpeg使用的技术。Dct是可逆的运算
        BW_8_8=BW(x:x+block-1,y:y+block-1);%得到边界矩阵。
        if m<=1 || n<=1
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

I=imread('lena.bmp');
[m,n] = size(D);
I(1:m,1:n) = D(:,:);    %将嵌入的水印写入到完整的图像中

%显示嵌入水印后的图像
subplot(3,2,4);imshow(I,[]);title('嵌入水印图像')
%保存该图像
I=uint8(I);
imwrite(I,'Linamarked.bmp');



%提取水印
T=imread('Linamarked.bmp');
T=double(T);
D = zeros(256,256);
D(:,:) = T(1:256,1:256);      %提取嵌入的数据

I=imread('lena.bmp');
I=double(I);
array2=zeros(1,InfoStrSize*8);
K=1;
l=1;
for m=1:blockno
    for n=1:blockno
        x=(m-1)*block+1;   y=(n-1)*block+1;%算出每格图像的坐标（x,y）,block=8,8*8的图像小格
        block_dct1=I(x:x+block-1,y:y+block-1);%取原始图像小格中的像素点到block_dct1矩阵中。
        block_dct2=D(x:x+block-1,y:y+block-1);
        Block_dct1=dct2(block_dct1);%对二维数组进行离散余弦变换。dct是有损压缩如jpeg使用的技术。Dct是可逆的运算
        Block_dct2=dct2(block_dct2);
        BW_8_8=BW(x:x+block-1,y:y+block-1);%得到边界矩阵。
        if m<=1|n<=1
            T=0;
        else
            T=sum(BW_8_8);   T=sum(T);
        end
        if T>T1
            Alpha=Alpha2;
            %block_dct1(1,1)=block_dct1(1,1)*(1+Alpha*mark(k));
            if l<=(InfoStrSize*8)
                tmp=(Block_dct2(1,1)/Block_dct1(1,1)-1);
                tmp=tmp/Alpha;
                tmp2=round(tmp);
                array2(l)=double(tmp2);
                l=l+1;
            end
        else
            Alpha= Alpha1;
            %block_dct1(1,1)=block_dct1(1,1)*(1+Alpha*mark(k));
        end
        k=k+1;
    end
end
subplot(3,2,5);
plot(array2);
title('提取水印');

extractedInfo=zeros(InfoStrSize,1);
for m=1:InfoStrSize
    infochar=0;
    for n=1:8
        if array2(8*(m-1)+n)==1
            infochar=infochar+bitset(0,n,1);
        end
    end
    extractedInfo(m)=infochar+extractedInfo(m);
end
resultStr=char(extractedInfo);
subplot(3,2,6);
plot(array2);
title(strcat('代表字符',resultStr))