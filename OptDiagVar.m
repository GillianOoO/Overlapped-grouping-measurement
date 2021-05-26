function [  pr, diagonal_var, exitflag ] = OptDiagVar( pr,iter )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
len = length(pr);
lb = zeros(1, len);
ub = ones(1, len);
nonlcon = @proCons;

A = [];
b = [];
Aeq = [];
beq = [];
%pr = 1/len * ones(1, len);

%options = optimoptions('fmincon','Display','notify','Algorithm','sqp');
%options = optimoptions('fmincon','SpecifyConstraintGradient',true);
% options=optimset('LargeScale','off','display','off','TolFun',0.0001,'TolX',0.0001,...
%    'GradObj','off', 'Hessian','off','DerivativeCheck','off');
% options=optimset('LargeScale','off','display','off','TolFun',0.0001,'TolX',0.0001,...
%    'GradObj','off', 'Algorithm', 'sqp','DerivativeCheck','off','PlotFcn',{@optimplotfval});
options=optimset('LargeScale','off','display','off','TolFun',0.0001,'TolX',0.0001,...
   'GradObj','off', 'MaxIter',iter,'Algorithm', 'sqp','DerivativeCheck','off','PlotFcn',{@optimplotfval});

[pr, diagonal_var, exitflag]=fmincon(@variance,pr,A,b,Aeq,beq,lb,ub,nonlcon,options);


end

