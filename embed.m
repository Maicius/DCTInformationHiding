
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
    Infochar=double(message_pad(m));  %% 'c'Ϊ99
    for n=1:8
        array(8*(m-1)+n)=bitget(Infochar,n);%%���Infochar��nλ��ֵ
    end
end
plot(array);
title('ԭʼˮӡ��Ϣ');
for m=1:blockno
    for n=1:blockno
        x=(m-1)*block+1;   y=(n-1)*block+1;%���ÿ��ͼ������꣨x,y��,block=8,8*8��ͼ��С��
        block_dct1=Img(x:x+block-1,y:y+block-1);%ȡԭʼͼ��С���е����ص㵽block_dct1�����С�
        block_dct1=dct2(block_dct1);%�Զ�ά���������ɢ���ұ任��dct������ѹ����jpegʹ�õļ�����Dct�ǿ��������
        BW_8_8=BW(x:x+block-1,y:y+block-1);%�õ��߽����
        if m<=1||n<=1
            T=0;
        else
            T=sum(BW_8_8);   T=sum(T);
        end
       if T>T1  %T1=3�������Ե����ֵ�� ����ͼ���ֻ�ڱ�Ե�϶�Ĳ���(��Ƶ)Ƕ��ˮӡ
            Alpha=Alpha2;
            %block_dct1(1,1)=block_dct1(1,1)*(1+Alpha*mark(k));
            if l<=(InfoStrSize*8)
                block_dct1(1,1)=block_dct1(1,1)*(1+Alpha*array(l));
                l=l+1;
            end
        else
            Alpha=Alpha1;
            % block_dct1(1,1)=block_dct1(1,1)*(1+Alpha*mark(k));  %����ͼ��ķǱ�Ե���ֲ�Ƕ��ˮӡ
        end
        Block_dct=idct2(block_dct1);
        D(x:x+block-1,y:y+block-1)=Block_dct;
        k=k+1;
    end
end

Y_waterMarked=imread('lena.bmp');
[m,n] = size(D);
Y_waterMarked(1:m,1:n) = D(:,:);    %��Ƕ���ˮӡд�뵽������ͼ����