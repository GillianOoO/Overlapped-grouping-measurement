function [ Ini_observ ] = sort_observ( Ini_observ)
% sort the observ with the weight.
MAX = 100000;

[m, Nq] = size(Ini_observ);
Nq = Nq - 1;

% for j = 1 : m
%     trace = TraceLocal(Ini_observ(j,2:Nq + 1));
%     weight(j) = abs(Ini_observ(j,1) * trace);
% end

%% sort the observables by its weight.
%% sort the observables based on the absolute value of the observables.
%% SeqNum : e.g. {3,2,4} sorted {4,3,2}, SeqNum = {3,1,2} the largest is the third one.
%% sort_seq: sorted sequence by absolute values
%% sort observable to a descending order with weight of observables.
%% SeqNum(j): the label of the j-th largest observables in the original sequence.
%% SortNum(j): the label of the j-th observables in the sorted sequence.
%% *Note* here we already changed the order of the original observ.
%% ori_seq = weight, here weight is the absoulte coefficients of the observables;

ori_seq = abs(Ini_observ(:,1));

sort_seq = sort(ori_seq,'descend');
for j = 1 : m
    for k = 1 : m
        if  sort_seq(j) == ori_seq(k)
            ori_seq(k) = MAX;
            SeqNum(j) = k;
            break;
        end
    end
end

SortNum = zeros(m,1);
for j = 1 : m
    SortNum(SeqNum(j)) = j;
end

ori_seq = zeros(m,1);
for j = 1 : m
    if ori_seq(j) == 0
        temp_observ = Ini_observ(j, :);
        Ini_observ(j, :) = Ini_observ(SeqNum(j), :);
        Ini_observ(SeqNum(j), :) = temp_observ;
        ori_seq(j) = 1;
        SeqNum(SortNum(j)) = SeqNum(j);%seq(x) = y
        SortNum(SeqNum(j)) = SortNum(j);%sort(y) = x
    end
    
end


end

