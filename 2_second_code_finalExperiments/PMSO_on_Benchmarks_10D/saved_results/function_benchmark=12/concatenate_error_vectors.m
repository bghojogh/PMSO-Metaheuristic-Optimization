clc
clear
close all

load errors1_3.mat 
errors1_3 = errors;
load errors4_11.mat 
errors4_11 = errors;
load errors12_16.mat 
errors12_16 = errors;
load errors17_30.mat 
errors17_30 = errors;

errors = [errors1_3(1:3), errors4_11(4:11), errors12_16(12:16), errors17_30(17:30)];

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