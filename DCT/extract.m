
function  [message_pad_recover]=extract(blocksize,column,row,S_Y_P_source)
% ��ȡ����:���ڸ�8��8�飬DCT�任����stepΪ������������SΪģȡ������
% if s/2<=����<s,then message bit is 1;
% else 0<=����<s/2,then message bit is 0;

step=1;%��������
s=15;%ģֵ

for y=0:(row/blocksize-1)
     for x=0:(column/blocksize-1)
         
          % transform block using DCT
          dct_block=dct2(S_Y_P_source((y*blocksize+1):(y+1)*blocksize, (x*blocksize+1):(x+1)*blocksize));

           % if s/2<=����<s,then message bit is 1;
           % else 0<=����<s/2,then message bit is 0;
           if ((s/2)<=(mod(dct_block(1,2)/step,s)))&&((mod(dct_block(1,2)/step,s))<=s)
                message_pad_recover(y*column/blocksize+x+1)=1;
           else
                message_pad_recover(y*column/blocksize+x+1)=0;
           end
                              
     end
end
  