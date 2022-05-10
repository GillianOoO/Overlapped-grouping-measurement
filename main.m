%author: Bujiao Wu

clear all;

global T

prompt = 'Please input a number in 1~2 to represent the program you wish to execute.\n(1/2: OGMV1/V2/ with cutting down stategy.):\n';

x = input(prompt); %%x in {1,2}

f = input('Please input file (E.g.: H2_4jw/H2_4bk/H2_4parity/...)\n','s');

f = strcat(f,'.txt');

T = input('Please input the number of copies for the probability distribution generation (E.g.: 100)\n');


if x == 1
    fprintf('OGMV1 cutdown:\n');
    time = main_CutOGM(f);
elseif x == 2
    fprintf('OGMV2 cutdown:\n');
    time = main_CUTOGMV2(f);
    
end
