clc
clear
close all

load errors1_5.mat 
errors1_5 = errors;
load errors6_10.mat 
errors6_10 = errors;
load errors11_17.mat 
errors11_17 = errors;
load errors18_22.mat 
errors18_22 = errors;
load errors23_24.mat 
errors23_24 = errors;
load errors25_28.mat
errors25_28 = errors;
load errors29_30.mat
errors29_30 = errors;

errors = [errors1_5(1:5), errors6_10(6:10), errors11_17(11:17), errors18_22(18:22), errors23_24(23:24), errors25_28(25:28), errors29_30(29:30)];

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