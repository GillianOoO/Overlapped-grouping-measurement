function [diagonal_var] = main_CUTGBCSV2(file)
%% for this version of GBCS, suppose we have s intervals in total.
%% we only add the observ in interval k to 2^(s-k) number of different sets.

MAX_step = 10;

global Nq m observ meas len pr
%% read observables
%%str = '/Users/wubujiao/Documents/MATLAB/ShadowTomography/Hamiltonian/';
str = 'Hamiltonian/';
str_set = 'CutSet/GBCSV3_';
strF = strcat(str, file);
strS = strcat(str_set, file);
display(strF);
observ = load(strF);

[m,Nq] = size(observ);
Nq = Nq - 1;

format = 'The number of photons: %d, the number of observables: %d\n';
fprintf(format, Nq, m);


%% sort_observables by its weight.
observ = sort_observ(observ);

%% generate the intervals.
min_weight = abs(observ(m,1));

%%generate the sets.
%%Strategy: from 1-->l, generate the commuted set for Q^(j) for 1<j<l,
%%where l<min{all observ are added, m/sqrt(Nq)}
 added = zeros(1, m);
 count_observ = 0; % end the loop if count_observ == m.
 cur = 0; %% current set number.
    
while 1
    j = 1;
    while j <=m && added(j) >0
        j = j + 1;
    end
    if j > m 
        break;
    end
    pos_j = floor(abs(observ(j,1))/min_weight);
    length_j = 0;
    while pos_j > 0
        length_j = length_j + 1;
        pos_j = floor(pos_j/10);
    end
    if added(j) > power(2,length_j-1) %% 2^length_j is an upper bound for observ_j
        continue;
    end
    cur = cur + 1;
    pr(cur) = abs(observ(j, 1));
    meas(:, cur) = observ(j,2:Nq+1);
    ele_cur(cur) = 1;
    set(ele_cur(cur), cur) = j;
    if added(j) == 0
       added(j) = 1; 
    else
        added(j) = added(j) + 1;
    end
    for k = 1 : m
        if k == j
            continue;
        end
        if ~IfCommute(observ(k,2:Nq+1), meas(:, cur))
            continue;
        end
        pos_k = floor(abs(observ(k,1))/min_weight);
        length_k = 0;
        while pos_k > 0
            length_k = length_k + 1;
            pos_k = floor(pos_k/10);
        end
        if added(k) > power(2,length_k-1) %% 2^length_k is an upper bound for observ_k
            continue;
        end
        meas(:, cur) = update_meas(meas(:, cur), observ(k,2:Nq+1));
        ele_cur(cur) = ele_cur(cur) + 1;
        set(ele_cur(cur), cur) = k;
        pr(cur) = pr(cur) + abs(observ(k,1));
        if added(k) == 0
            added(k) = 1;
        else
            added(k) = added(k)+1;
        end

    end
    for k = 1 : m
        if ~IfCommute(observ(k,2:Nq+1), meas(:, cur))
            continue;
        end
        for l = 1 : ele_cur
           if set(l,cur) == k
              break;
           end
        end
        if l <= ele_cur
           continue; 
        end
        meas(:, cur) = update_meas(meas(:, cur), observ(k,2:Nq+1));
        ele_cur(cur) = ele_cur(cur) + 1;
        set(ele_cur(cur), cur) = k;
    end
end

len = cur;
fprintf('the number of sets: %d\n', len);
pr = pr(1:len);
sum_pr = 0;
for j = 1 : len
    sum_pr = sum_pr + pr(j);
end
for j = 1 : len
    pr(j) = pr(j)/sum_pr;
end

tic
exitflag = 0;
T = 1000; %% if the result is not good, we should amplify this.
for step = 1 : MAX_step
    %%sorting the meas with probability descending.
    measAndP(1:Nq,1:len) = meas(:,1:len);
    measAndP(Nq+1,1:len) = pr(1:len);
    measAndP = measAndP(:,1:len);
    measAndP = sort_meas(measAndP);%sort
    meas = measAndP(1:Nq,:);
    pr = measAndP(Nq+1,:);
%     [new_len, new_pr] = CutDownSet(pr, T);%%cutdown
%     if abs(new_len - len) < Nq
%        break; 
%     end
    [new_len, new_pr] = CutMoreSet(pr, T);%%cutdown
    if variance(new_pr) < variance(pr)
        pr = new_pr;
        len = new_len;
    elseif exitflag == 1
       break; 
    end
    meas = meas(:,1:len);
    format = '%d-th round: The number of sets: %d.\n';
    fprintf(format, step, len);
    upper_B = min(10*step, 20);
    [pr, diagonal_var, exitflag] = OptDiagVar(pr, upper_B);
end
if exitflag == 0
    [pr, diagonal_var, exitflag] = OptDiagVar(pr, 100);
end

timeSpend = toc;
fprintf('Time cost:%f; %d rounds in total; Optimal diagonal var: %f\n', timeSpend, step, diagonal_var);

save(strS,'meas','pr','-ascii');

end


 