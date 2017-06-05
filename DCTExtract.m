%************* DCT域熵掩蔽模型水印算法-提取
clc
clear all;
close all;

%读入攻击后的图像
Img=imread('final.bmp');  %路径根据图像具体保存位置修改

[row, column]=size(Img);
MP_source=reshape(Img,[],1);
blocksize=8;                        %分块尺寸
L=length(MP_source);                %图像数据总数
number_blocks=L/(blocksize^2);      %计算分块数
Img_Wdct=Img;

% 水印图像预处理
% [message_pad]=copyright(number_blocks); 

% 水印提取
[message_pad_recover]=extract(blocksize,column,row,Img_Wdct);

row_picture=64;             %水印图像的垂直像素数
column_show=floor(length(message_pad_recover)/row_picture);  %嵌入的水印图像的列数

% 显示提取的水印图像
message_embed=message_pad_recover(1:column_show*row_picture);
messaage_embed_reshape=reshape(message_embed,[row_picture,column_show]);
message_show=mat2gray(messaage_embed_reshape);
imshow(message_show);
title('提取的版权图像');
%复原
n=14;    %384 for 512 * 512
a=3;b=5;
N=64
img=message_show;
for i=1:n
    i
    for y=1:64
        for x=1:64            
            xx=mod((a*b+1)*(x-1)-b*(y-1),N)+1;
            yy=mod(-a*(x-1)+(y-1),N)+1  ;        
            message_show(yy,xx)=img(y,x);                   
        end
    end
    img=message_show;
    figure(2)
    imshow(img,[]);
    title('恢复图像')
end

% 显示提取错误比特的比例
% [message_pad,message_embed]=copyright(number_blocks);
% len=length(message_embed);
% bit_error_rate=sum(abs(message_pad_recover(1:len)-double(message_embed)))/len;
