%************* DCT�����ڱ�ģ��ˮӡ�㷨-��ȡ
clc
clear all;
close all;

%���빥�����ͼ��
Img=imread('final.bmp');  %·������ͼ����屣��λ���޸�

[row, column]=size(Img);
MP_source=reshape(Img,[],1);
blocksize=8;                        %�ֿ�ߴ�
L=length(MP_source);                %ͼ����������
number_blocks=L/(blocksize^2);      %����ֿ���
Img_Wdct=Img;

% ˮӡͼ��Ԥ����
% [message_pad]=copyright(number_blocks); 

% ˮӡ��ȡ
[message_pad_recover]=extract(blocksize,column,row,Img_Wdct);

row_picture=64;             %ˮӡͼ��Ĵ�ֱ������
column_show=floor(length(message_pad_recover)/row_picture);  %Ƕ���ˮӡͼ�������

% ��ʾ��ȡ��ˮӡͼ��
message_embed=message_pad_recover(1:column_show*row_picture);
messaage_embed_reshape=reshape(message_embed,[row_picture,column_show]);
message_show=mat2gray(messaage_embed_reshape);
imshow(message_show);
title('��ȡ�İ�Ȩͼ��');
%��ԭ
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
    title('�ָ�ͼ��')
end

% ��ʾ��ȡ������صı���
% [message_pad,message_embed]=copyright(number_blocks);
% len=length(message_embed);
% bit_error_rate=sum(abs(message_pad_recover(1:len)-double(message_embed)))/len;
