function [len, pr] = CutMoreSet(pr, T)
%% T *p1, ..., T*ps, cut measurements with indices: s+1..length(pr)


count = 0;
s = 0;
len = length(pr);

while count < T && s < len
    s = s + 1;
    %%no rand here
    sum = ceil(T * pr(s));
    for k = 1 : sum
       count = count + 1;
       if count >= T
          break; 
       end
    end
end
if s < len
    len = s;
    
    pr = pr(1:len);
    
    sum = 0; %normalized pr.
    for j = 1 : len
        sum = sum + pr(j);
    end
    for j = 1 : len
        pr(j) = pr(j)/sum;
    end
end

end

