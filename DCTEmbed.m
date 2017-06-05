% ************* ����DCT�任��ͼ��ˮӡ�㷨ʵ�֣�ˮӡǶ�� **************
clc
clear all;
close all;

Img=imread('lena.jpg');  %����ͼ�� 

% ��ɫͼ��ת��Ϊ�Ҷ�ͼ��
if ndims(Img)==3
    Img=rgb2gray(Img);               
else
    Img=Img;                    
end

% ��ԭʼͼ��
subplot(1, 4, 1)
imshow(Img);
title('ԭʼͼ��');

[row, column]=size(Img);             
MP_source=reshape(Img',[],1);
Orignal_source=MP_source;           %ԭʼͼ�����ݱ���
blocksize=8;                        %�ֿ�ߴ�
L=length(MP_source);                %ͼ����������
number_blocks=L/(blocksize^2);      %����ֿ���

% ˮӡͼ��Ԥ����
[message_pad]=copyright(number_blocks); 
  
% Ƕ��ˮӡ 
[waterMarked]=embed(Img,row,column,blocksize,message_pad); 

Img_W=uint8(waterMarked);
subplot(1, 4, 4);
imshow(Img_W);
title('Ƕ��ˮӡ��ͼ��');
imwrite(Img_W,'final.bmp'); 

% ����PSNR
S=PSNR(Img_W,Img),
