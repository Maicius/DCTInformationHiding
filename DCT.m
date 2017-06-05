clear()
subplot(1,3,1); 
I=imread('lena.bmp','bmp'); 
%I=I(1:M,1:M);
imshow(I);
title('Ô´Í¼Ïñ');

[count,msg,data]=hidedctadv0('Lena.bmp','1.jpg','1.txt',1982,1);
subplot(1,3,2); 
imshow(data);
title('Òþ²ØÖÐÍ¾µÄÍ¼Æ¬');

[count,msg,data]=hidedctadv('Lena.bmp','1.jpg','1.txt',1982,1);
subplot(1,3,3); 
imshow(data);
title('Òþ²ØºóµÄÍ¼Æ¬');
