function a = unarnold()

%读取加密图像
aa=imread('temp.bmp');

%和原来一样置换一次
iTimes=2;
[iH, iW]=size(aa);
if iH ~= iW % 必须是正方形
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

%输出原图
imwrite(outImg,'unmysecret.bmp')
