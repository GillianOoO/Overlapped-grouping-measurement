function [len, pr] = CutDownSet(pr, T)
%% T *p1, ..., T*ps, cut measurements with indices: s+1..length(pr)


count = 0;
s = 0;
len = length(pr);

while count < T && s < len
    s = s + 1;
    %%sum = ceil(T * pr(s));
    %random.
    x = rand();
    amount = T * pr(s);
    if amount > 1
        sum = floor(amount);
        if x < mod(amount, sum)
           sum = sum + 1;
        end
    else
        s = s + T - count;
        break;
    end
    for k = 1 : sum
       count = count + 1;
       if count >= T
          break; 
       end
    end
end
if s < len
    len = s;
    
    pr = pr(1,1:len);
    
    sum = 0; %normalized pr.
    for j = 1 : len
        sum = sum + pr(j);
    end
    for j = 1 : len
        pr(j) = pr(j)/sum;
    end
end
end

