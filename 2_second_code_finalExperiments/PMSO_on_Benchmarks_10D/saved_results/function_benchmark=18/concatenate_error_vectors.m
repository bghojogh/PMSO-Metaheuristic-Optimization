clc
clear
close all

load errors1.mat 
errors1 = errors;
load errors2_5.mat 
errors2_5 = errors;
load errors6_8.mat 
errors6_8 = errors;
load errors9_14.mat 
errors9_14 = errors;
load errors15_22.mat 
errors15_22 = errors;
load errors23_30.mat 
errors23_30 = errors;

errors = [errors1(1), errors2_5(2:5), errors6_8(6:8), errors9_14(9:14), errors15_22(15:22), errors23_30(23:30)];

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