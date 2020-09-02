load errors1_22.mat 
errors1_22 = errors;
load errors23_end.mat
errors23_end = errors;

errors = [errors1_22(1:22), errors23_end(23:end)];

%%%%%% finding the best (least) error:
best_error = min(errors);
%%%%%% Averaging errors of runs:
mean_error = mean(errors);
%%%%%% finding the standard deviation of runs:
standard_deviation_error = sqrt(var(errors));

save best_error.mat best_error
save mean_error.mat mean_error
save standard_deviation_error.mat standard_deviation_error

