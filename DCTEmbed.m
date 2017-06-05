% ************* 基于DCT变换的图像水印算法实现－水印嵌入 **************
clc
clear all;
close all;

Img=imread('lena.jpg');  %读入图像 

% 彩色图像转换为灰度图像
if ndims(Img)==3
    Img=rgb2gray(Img);               
else
    Img=Img;                    
end

% 画原始图像
subplot(1, 4, 1)
imshow(Img);
title('原始图像');

[row, column]=size(Img);             
MP_source=reshape(Img',[],1);
Orignal_source=MP_source;           %原始图像数据备份
blocksize=8;                        %分块尺寸
L=length(MP_source);                %图像数据总数
number_blocks=L/(blocksize^2);      %计算分块数

% 水印图像预处理
[message_pad]=copyright(number_blocks); 
  
% 嵌入水印 
[waterMarked]=embed(Img,row,column,blocksize,message_pad); 

Img_W=uint8(waterMarked);
subplot(1, 4, 4);
imshow(Img_W);
title('嵌入水印的图像');
imwrite(Img_W,'final.bmp'); 

% 计算PSNR
S=PSNR(Img_W,Img),
