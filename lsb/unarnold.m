function a = unarnold()

%��ȡ����ͼ��
aa=imread('temp.bmp');

%��ԭ��һ���û�һ��
iTimes=2;
[iH, iW]=size(aa);
if iH ~= iW % ������������
    error('The cover must be a square !');
    return;
end
outImg=uint8(zeros(iH,iW));
tempImg=aa;
for i=1:iTimes
         for u=1:iH
            for v=1:iW
                temp=tempImg(u,v);
                 ax=mod((u-1)+(v-1),iW)+1;  
                 ay=mod(2*(u-1)+3*(v-1),iW)+1;
                outImg(ax,ay)=temp;
            end
         end
         tempImg=outImg;
end


outImg=tempImg;
figure, imshow(outImg);

%���ԭͼ
imwrite(outImg,'unmysecret.bmp')
