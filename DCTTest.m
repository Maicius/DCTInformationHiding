clear;
clc;
s=256;      %s
block=8;
blockno=s/block;%һ����32��
% LENGTH=s*s/64;
Alpha1=0.025;
Alpha2=0.1;
T1=3;
I=zeros(s,s);%����ȫ����
D=zeros(s,s);
BW=zeros(s,s);
Block_dct1=zeros(block,block);
%����ˮӡ������ʾˮӡ��Ϣ��
subplot(3,2,1);
<<<<<<< HEAD
Info = imread('hello64.bmp');
info=Info(:, :, 1);

=======
Info='abc';
>>>>>>> master
InfoStrSize=length(Info);
%���ַ���ת��Ϊλ����
array=zeros(1,InfoStrSize*8);
for m=1:InfoStrSize
    Infochar=double(Info(m));  %% 'c'Ϊ99
    for n=1:8
        array(8*(m-1)+n)=bitget(Infochar,n);%%���Infochar��nλ��ֵ
    end
end
plot(array);
title('ԭʼˮӡ��Ϣ');

%��ʾԭͼ
subplot(3,2,2);
i=imread('lena.bmp');
imshow(i,[]);
title('ԭʼͼ��')

%��ʾprewittΪ���ӵı�Եͼ  �ں�����⵽��Ե�ĵط�Ϊ1�������ط�Ϊ0
BW=edge(i,'prewitt');      %�Զ�ѡ����ֵ��prewitt���ӽ��б�Ե��⡣
%BW=edge(I,��Roberts��);
%BW=edge(I,��Sobel��);
%BW=edge(I,��zerocross��);
subplot(3,2,3);imshow(BW);
title('ԭʼͼ���Եͼ');


%Ƕ��ˮӡ
l=1;
k=1;
for m=1:blockno
    for n=1:blockno
        x=(m-1)*block+1;   y=(n-1)*block+1;%���ÿ��ͼ������꣨x,y��,block=8,8*8��ͼ��С��
        block_dct1=i(x:x+block-1,y:y+block-1);%ȡԭʼͼ��С���е����ص㵽block_dct1�����С�
        block_dct1=dct2(block_dct1);%�Զ�ά���������ɢ���ұ任��dct������ѹ����jpegʹ�õļ�����Dct�ǿ��������
        BW_8_8=BW(x:x+block-1,y:y+block-1);%�õ��߽����
        if m<=1 || n<=1
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

I=imread('lena.bmp');
[m,n] = size(D);
I(1:m,1:n) = D(:,:);    %��Ƕ���ˮӡд�뵽������ͼ����

%��ʾǶ��ˮӡ���ͼ��
subplot(3,2,4);imshow(I,[]);title('Ƕ��ˮӡͼ��')
%�����ͼ��
I=uint8(I);
imwrite(I,'Linamarked.bmp');



%��ȡˮӡ
T=imread('Linamarked.bmp');
T=double(T);
D = zeros(256,256);
D(:,:) = T(1:256,1:256);      %��ȡǶ�������

I=imread('lena.bmp');
I=double(I);
array2=zeros(1,InfoStrSize*8);
K=1;
l=1;
for m=1:blockno
    for n=1:blockno
        x=(m-1)*block+1;   y=(n-1)*block+1;%���ÿ��ͼ������꣨x,y��,block=8,8*8��ͼ��С��
        block_dct1=I(x:x+block-1,y:y+block-1);%ȡԭʼͼ��С���е����ص㵽block_dct1�����С�
        block_dct2=D(x:x+block-1,y:y+block-1);
        Block_dct1=dct2(block_dct1);%�Զ�ά���������ɢ���ұ任��dct������ѹ����jpegʹ�õļ�����Dct�ǿ��������
        Block_dct2=dct2(block_dct2);
        BW_8_8=BW(x:x+block-1,y:y+block-1);%�õ��߽����
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
title('��ȡˮӡ');

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
title(strcat('�����ַ�',resultStr))