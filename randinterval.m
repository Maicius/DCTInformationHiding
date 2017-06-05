function [row, col] = randinterval(matrix, count, key)
%randinterval.m
% ������������������н��м�����ƣ�ѡ����Ϣ����λ
% matrix Ϊ�������
% row Ϊα�������������б�
% col Ϊα�������������б�
% key Ϊ��Կ
% count ΪҪǶ�����Ϣ������Ҫѡ�������������
%
[m, n] = size(matrix);
interval1 = floor(m * n/count) + 1;
interval2 = interval1 - 2;
if interval2 == 0
    error('����̫С���ܽ�������Ϣ���ؽ�ȥ');
end
rand('seed',key);
a = rand(1, count);
row = zeros([1 count]);
col = zeros([1 count]);
r = 1;
c = 1;
row(1,1) = r;
col(1,1) = c;
for i =2:count
    if a(i) >= 0.5
        c = c + interval1;
    else
        c = c + interval2;
    end
    if c > n
        r = r + 1;
        if r > m
            error('����̫С���ܽ�������Ϣ���ؽ�ȥ');
        end
        c = mod(c, n);
        if c == 0
            c = 1;
        end
    end
    row(1, i) = r;
    col(1, i) = c;
end
