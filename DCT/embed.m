
function [Y_waterMarked]=embed(S_Y_P_source,row,column,blocksize,message_pad)

% 嵌入规则:对于各8×8块，DCT变换后以step为步长量化，以S取模。
% if message bit is 0,coefficient+s/4;
% if message bit is 1,coefficient+3*s/4;
 
     step=1;%量化步长
     s=15;%模值
    alpha1 = s/4;
    alpha2 = 3*s/4;
      for y=0:(row/blocksize-1)
          for x=0:(column/blocksize-1)
              
             % transform block using DCT
             dct_block=dct2(S_Y_P_source((y*blocksize+1):(y+1)*blocksize,(x*blocksize+1):(x+1)*blocksize));
             dct_block_WM=dct_block;
             
             % DCT变换后以step为步长量化，以S取模。
             messured_dct_block=dct_block/step;
             relaxed_messured_dct_block=messured_dct_block-mod(messured_dct_block,s);            
             
             % if message bit is 0　elseif message bit is 1
             if (message_pad(y*column/blocksize+x+1) == 0)
                dct_block_WM(1,2)=relaxed_messured_dct_block(1,2)+alpha1;
                 dct_block_WM(3,1)=relaxed_messured_dct_block(3,1)+alpha1;
                 dct_block_WM(4,4)=relaxed_messured_dct_block(4,4)+alpha1;
            elseif (message_pad(y*column/blocksize+x+1) == 1) 
                
                 dct_block_WM(1,2)=relaxed_messured_dct_block(1,2)+alpha2;
                 dct_block_WM(3,1)=relaxed_messured_dct_block(3,1)+alpha2;
                 dct_block_WM(4,4)=relaxed_messured_dct_block(4,4)+alpha2;
             end
                
             % transform block back into spatial domain
            Y_waterMarked( y*blocksize+1:(y+1)*blocksize,x*blocksize+1:(x+1)*blocksize)=idct2(dct_block_WM); 
            
         end
      end
