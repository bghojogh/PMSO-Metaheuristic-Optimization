clc
clear
close all

load errors1_3.mat 
errors1_3 = errors;
load errors4_7.mat 
errors4_7 = errors;
load errors8_14.mat 
errors8_14 = errors;
load errors15_24.mat 
errors15_24 = errors;
load errors25_30.mat 
errors25_30 = errors;

errors = [errors1_3(1:3), errors4_7(4:7), errors8_14(8:14), errors15_24(15:24), errors25_30(25:30)];

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