function [var] = L1sampling(f, mole)
%% L1 sampling:
%% Pr(Q) = |alp_Q|/l1norm l1norm = sum_Q |alp_Q|
%% v = sum_Q alp_Q f(Q) mu(Q), f(Q) = [P=Q]/Pr(Q)
%% var(v) = sum_Q alp_Q^2 1/Pr(Q) - tr(rho Q)^2

global Nq phi


% %phi = [1;0;0;0;1;0;0;0]; %%H2_8jw
% phi = [1;0;1;0]; %%H2_4jw
% phi = [1;0;0;0;0;0;1;0;0;0;0;0]; %% LiH_14 100000100000

%%str = '/Users/wubujiao/Documents/MATLAB/ShadowTomography/Hamiltonian/';
str = '/Hamiltonian/';
strF = strcat(str, f);
display(strF);
observ = load(strF);

[m,Nq] = size(observ);
Nq = Nq - 1;
display(Nq);
display(m);

phi = get_HarTree(mole);
phi


norm = 0;
ZerosMat = zeros(1,Nq);
for j = 1 : m
    if ZerosMat == observ(j,2:Nq + 1)
       continue; 
    end
    norm = norm + abs(observ(j,1));
end

varT = 0;


for j = 1 : m
   % temp = observ(j,1) * TraceGHZ(observ(j,2:Nq+1));
    if ZerosMat == observ(j,2:Nq + 1)
       continue; 
    end
    temp = observ(j,1) * TraceLocal(observ(j, 2:Nq+1));
    varT = varT + temp;
end

var = norm^2 - varT^2;

format = 'The number of photons: %d, the number of observables: %d; Variance: %f';
fprintf(format, Nq, m, var);

% %% write to the file
% file = fopen('output.txt','w');
% fprintf(file, 'GBCS\n');
%  format = 'Photons: %d\nObservables: %d\n';
% fprintf(file, format, Nq, m);
% format = 'variance: %f';
% fprintf(file,format ,var);
% fclose(file); 

end
