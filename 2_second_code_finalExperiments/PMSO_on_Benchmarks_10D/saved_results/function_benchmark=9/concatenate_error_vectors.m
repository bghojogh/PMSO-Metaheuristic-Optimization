clc
clear
close all

load errors1_3.mat 
errors1_3 = errors;
load errors4_6.mat 
errors4_6 = errors;
load errors7_19.mat 
errors7_19 = errors;
load errors20_23.mat 
errors20_23 = errors;
load errors24_27.mat 
errors24_27 = errors;
load errors28_30.mat
errors28_30 = errors;

errors = [errors1_3(1:3), errors4_6(4:6), errors7_19(7:19), errors20_23(20:23), errors24_27(24:27), errors28_30(28:30)];

%%%%%% finding the best (least) error:
best_error = min(errors);
%%%%%% Averaging errors of runs:
mean_error = mean(errors);
%%%%%% finding the standard deviation of runs:
standard_deviation_error = sqrt(var(errors));

save best_error.mat best_error
save mean_error.mat mean_error
save standard_deviation_error.mat standard_deviation_error

%%%%% display results:
disp('best_error: '); disp(best_error);
disp('mean_error: '); disp(mean_error);
disp('standard_deviation_error: '); disp(standard_deviation_error);