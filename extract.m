
function  [message_pad_recover]=extract(block,column,row,T)
%��ȡˮӡ
T=double(T);
Img = imread('lena.jpg');
D = zeros(column,row);
D(:,:) = T(1:column,1:row);      %��ȡǶ�������
Alpha1=0.025;
Alpha2=0.1;
BW=zeros(row,column);

blockno=row/block;
message_pad_recover=zeros(64,64);
l=1;
k=1;
T1=3;
for m=1:blockno
    for n=1:blockno
        x=(m-1)*block+1;   
        y=(n-1)*block+1;%���ÿ��ͼ������꣨x,y��,block=8,8*8��ͼ��С��
        block_dct1=Img(x:x+block-1,y:y+block-1);%ȡԭʼͼ��С���е����ص㵽block_dct1�����С�
        block_dct2=D(x:x+block-1,y:y+block-1);
        Block_dct1=dct2(block_dct1);%�Զ�ά���������ɢ���ұ任��dct������ѹ����jpegʹ�õļ�����Dct�ǿ��������
        Block_dct2=dct2(block_dct2);
        BW_8_8=BW(x:x+block-1,y:y+block-1);%�õ��߽����
        if m<=1||n<=1
            T=0;
        else
            T=sum(BW_8_8);   T=sum(T);
        end
        if T>T1
            Alpha=Alpha2;
            %block_dct1(1,1)=block_dct1(1,1)*(1+Alpha*mark(k));
            tmp=(Block_dct2(1,1)/Block_dct1(1,1)-1);
            tmp=tmp/Alpha;
            tmp2=round(tmp);
            message_pad_recover(l)=double(tmp2);
            l=l+1;
        else
            Alpha= Alpha1;
            %block_dct1(1,1)=block_dct1(1,1)*(1+Alpha*mark(k));
        end
        k=k+1;
    end
end
