clc
clear
close all

load errors1_10.mat 
errors1_10 = errors;
load errors11_30.mat 
errors11_30 = errors;

errors = [errors1_10(1:10), errors11_30(11:30)];

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