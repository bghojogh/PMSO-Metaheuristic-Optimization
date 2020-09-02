clc
clear
close all

load errors1_3.mat 
errors1_3 = errors;
load errors4_5.mat 
errors4_5 = errors;
load errors6_9.mat 
errors6_9 = errors;
load errors10.mat 
errors10 = errors;
load errors11_19.mat 
errors11_19 = errors;
load errors20_25.mat
errors20_25 = errors;
load errors26_30.mat
errors26_30 = errors;

errors = [errors1_3(1:3), errors4_5(4:5), errors6_9(6:9), errors10(10), errors11_19(11:19), errors20_25(20:25), errors26_30(26:30)];

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