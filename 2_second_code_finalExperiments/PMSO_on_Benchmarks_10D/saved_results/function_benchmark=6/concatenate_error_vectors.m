clc
clear
close all

load errors1_6.mat 
errors1_6 = errors;
load errors7_12.mat 
errors7_12 = errors;
load errors13_19.mat 
errors13_19 = errors;
load errors20_27.mat 
errors20_27 = errors;
load errors28_30.mat 
errors28_30 = errors;

errors = [errors1_6(1:6), errors7_12(7:12), errors13_19(13:19), errors20_27(20:27), errors28_30(28:end)];

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