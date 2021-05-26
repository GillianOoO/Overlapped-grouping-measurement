function [c,ceq] = proCons(pr)

% len = size(pr,2);
global len

ceq = -1;

for j = 1: len
    ceq = ceq + pr(j);
end


c=0;


end