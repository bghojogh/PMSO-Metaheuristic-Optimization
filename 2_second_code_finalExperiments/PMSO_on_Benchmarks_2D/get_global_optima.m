function [actual_global_optima_location, actual_global_optima_fitness] = get_global_optima(func_num, Number_of_dimensions_of_landscape)

%%%%%%% Load actual global optimas in landscape functions:
load('global_optima.mat');  % the name of its variable is "o"
actual_global_optima_location = o(func_num, :);

%%%%%%% correcting actual_global_optima in some cases according to instruction of benchmark dataset (Read the README.txt file or the document of CEC 2005):
D = Number_of_dimensions_of_landscape;
if func_num == 5
    actual_global_optima_location(1:ceil(D/4))=-100;
    actual_global_optima_location(max(floor(0.75*D),1):D)=100;
elseif func_num == 8
    actual_global_optima_location(2.*[1:floor(D/2)]-1)=-32;
elseif func_num == 20
    actual_global_optima_location(1,2.*[1:floor(D/2)])=5;
else
    % do not change
end

%%%%%%% Just take the elements of actual_global_optima in used dimensions:
actual_global_optima_location = actual_global_optima_location(1:D);

%%%%%%%
global initial_flag
initial_flag=0;
actual_global_optima_fitness = benchmark_func(actual_global_optima_location,func_num);

end