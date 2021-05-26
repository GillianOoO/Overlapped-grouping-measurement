function [ res ] = IfCommute(A,B)
%UNTITLED Summary of this function goes here
%   judge if two observable is commute (not exactly commute, wether measure A can be used to measure B).
% here we use 0->I, 1->X, 2->Y,3->Z. So meas[i] is a vector with length Nq and elements in {0,1,2,3}.
% if two observ commute, then each entry of two observ equals or one entry equals 0.
%% length is Nq.

res = true;

%%global Nq

Nq = length(A);

for i = 1 : Nq
   if A(i) ~= B(i) && A(i) ~= 0 && B(i) ~=0
       res = false;
       return
   end
end

end
