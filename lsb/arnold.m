%function a = arnold()
%读取图像</span>
aa=imread('WTMSB5.bmp');

%置换次数
iTimes=2;

%读取aa图像大小
[iH, iW]=size(aa);
%if iH ~= iW % 必须是正方形
%    error('The cover must be a square !');
%    return;
%end
%矩阵转换
%outImg=uint24(zeros(iH,iW));
tempImg=aa;
for i=1:iTimes 
        for u=1:iH
            for v=1:iW
                temp=tempImg(u,v);
%置乱  取模运算
                ax=mod(3*(u-1)-(v-1),iW)+1;
                ay=mod((v-1)-2*(u-1),iW)+1;

                outImg(ax,ay)=temp;
            end
        end
      tempImg=outImg;
end
outImg=tempImg;

%图像展示</span>
figure, imshow(outImg);

%将置乱后的图像保存为：
imwrite(outImg,'mysecret.bmp')
