%function a = arnold()
%��ȡͼ��</span>
aa=imread('WTMSB5.bmp');

%�û�����
iTimes=2;

%��ȡaaͼ���С
[iH, iW]=size(aa);
%if iH ~= iW % ������������
%    error('The cover must be a square !');
%    return;
%end
%����ת��
%outImg=uint24(zeros(iH,iW));
tempImg=aa;
for i=1:iTimes 
        for u=1:iH
            for v=1:iW
                temp=tempImg(u,v);
%����  ȡģ����
                ax=mod(3*(u-1)-(v-1),iW)+1;
                ay=mod((v-1)-2*(u-1),iW)+1;

                outImg(ax,ay)=temp;
            end
        end
      tempImg=outImg;
end
outImg=tempImg;

%ͼ��չʾ</span>
figure, imshow(outImg);

%�����Һ��ͼ�񱣴�Ϊ��
imwrite(outImg,'mysecret.bmp')
