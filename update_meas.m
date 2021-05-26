function [ new ] = update_meas(meas, ele)

%% update measurement meas by adding element ele
%% 0->I, 1->X, 2->Y, 3->Z

global Nq

new = zeros(1,Nq);

for j = 1 : Nq
   if meas(j) == 0 && ele(j)>0
      new(j) = ele(j);
   else
       new(j) = meas(j);
   end
end




end