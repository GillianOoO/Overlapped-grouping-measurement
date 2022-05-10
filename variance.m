function [var] = variance(pr,observ, meas, T)

 %global observ meas T

 len = length(pr);
 

 
 [m, Nq] = size(observ); 
 Nq = Nq - 1;
 
%% diagonal variance %% if there exists an observable Q, which has no rela
var = 0;
for j = 1 : m % observ(j)
    temp = 0;
    for k = 1 : len % meas(k)
        if IfCommute(observ(j,2:Nq+1),meas(:,k))
            temp = temp + pr(k);
        end
    end
    if temp ~= 0
    var = var + observ(j,1)^2/temp;
    else
        var = var + observ(j,1)^2*T;
    end
end

end
