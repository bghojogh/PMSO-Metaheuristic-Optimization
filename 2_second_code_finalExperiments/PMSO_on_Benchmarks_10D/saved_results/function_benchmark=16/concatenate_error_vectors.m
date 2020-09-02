clc
clear
close all

load errors1_8.mat 
errors1_8 = errors;
load errors9_11.mat 
errors9_11 = errors;
load errors12_30.mat 
errors12_30 = errors;

errors = [errors1_8(1:8), errors9_11(9:11), errors12_30(12:30)];

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