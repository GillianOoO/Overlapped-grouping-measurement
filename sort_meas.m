function [ measAndP ] = sort_meas( measAndP)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% sorting measurements by its probability with descending order.
% The first Nq rows are observalbes, each a column, and the last row in
% this column is the probability of it.
MAX = 100000;

[Nq, len] = size(measAndP);
Nq = Nq - 1;

ori_seq = measAndP(Nq+1,:);

sort_seq = sort(ori_seq,'descend');
for j = 1 : len
    for k = 1 : len
        if  sort_seq(j) == ori_seq(k)
            ori_seq(k) = MAX;
            SeqNum(j) = k;
            break;
        end
    end
end

SortNum = zeros(len,1);
for j = 1 : len
    SortNum(SeqNum(j)) = j;
end

ori_seq = zeros(1, len);
for j = 1 : len
    if ori_seq(j) == 0
        temp_observ = measAndP(:, j);
        measAndP(:, j) = measAndP(:, SeqNum(j));
        measAndP(:, SeqNum(j)) = temp_observ;
        ori_seq(j) = 1;
        SeqNum(SortNum(j)) = SeqNum(j);%seq(x) = y
        SortNum(SeqNum(j)) = SortNum(j);%sort(y) = x
    end
end

end

