%% Calculate variance.
 clear all;
addpath(genpath('./'))

% global Nq m observ len meas pr

 prompt = 'Please input a number in 1~2 to represent the program you wish to execute.\n(1/2: OGMV1/V2/ with cutting down stategy.):\n';

 x = input(prompt); %%x in {0,1,2,3,4,5} 5: Under construction

 f = input('Please input file (E.g.: H2_4jw/H2_4bk/H2_4parity/...)\n','s');

 f = strcat(f,'.txt');


if x == 1
    fprintf('OGMV1 cutdown:\n');
    diagonal_var = main_CutOGM(f);
    display(diagonal_var);
elseif x == 2
    fprintf('OGMV2 cutdown:\n');
    diagonal_var = main_CUTOGMV2(f);
    display(diagonal_var);
end
