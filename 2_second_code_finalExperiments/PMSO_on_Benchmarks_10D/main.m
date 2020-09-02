%% Applying Optimization Algorithm on Benchmarks:

%% MATLAB initializations:
clc
clear
clear all
close all

%% Add paths of functions and data:
addpath('./algorithms')
addpath('./benchmarks')
global initial_flag

%% Settings of experiments:
%function_landscape = 15;  % should be an integer in limit [1, Number_of_landscape_functions]
Number_of_runs = 30;
Number_of_landscape_functions = 25;
Number_of_particles = 40;   %--> population size
global Number_of_dimensions_of_landscape; Number_of_dimensions_of_landscape = 10;   % should be <= 100 (according to data in benchmark dataset)
global Maximum_number_of_function_evaluations; Maximum_number_of_function_evaluations = Number_of_dimensions_of_landscape * 10000;  % according to instruction of benchmark dataset and other papers

%% Settings of Algorithm:
%%%%%% parameters of local search iterations:
global Number_of_iterations_in_LocalSearch;
global lowerBound_of_iterationLocalSearch;
%%%%%% parameters of wave determination:
global fraction_of_particles_close_to_sea_edge;
%%%%%% parameters of local search neighborhood:
global fraction_of_distance_from_globalBest_for_neighborhood;
global neighborhood_of_globalBest_particle;
global initial_neighborhood;
global rate_change_neighborhood;
global lowerBound_of_neighborhood;
global upperBound_of_neighborhood;
global FitnessHistory_window_ChangeNeighbourhood;

for function_landscape = 18:18  %Number_of_landscape_functions  % should be an integer in limit [1, Number_of_landscape_functions]
%% Multiple executions of algorithm:
errors = zeros(1, Number_of_runs);
%%%%%%% Settings of PMSO algorithm:
[bounds_of_search, initialization_range] = get_bounds_of_benchmark(function_landscape);
if bounds_of_search(2) == 100
    Number_of_iterations_in_LocalSearch = 30;
    lowerBound_of_iterationLocalSearch = 10;
    fraction_of_particles_close_to_sea_edge = 0.5;
    fraction_of_distance_from_globalBest_for_neighborhood = 0.1;
    neighborhood_of_globalBest_particle = 2;
    initial_neighborhood = 5;
    rate_change_neighborhood = 0.3;
    lowerBound_of_neighborhood = 0.5;
    upperBound_of_neighborhood = 10;
    FitnessHistory_window_ChangeNeighbourhood = 5;
elseif bounds_of_search(2) == 32
    Number_of_iterations_in_LocalSearch = 30;
    lowerBound_of_iterationLocalSearch = 10;
    fraction_of_particles_close_to_sea_edge = 0.5;
    fraction_of_distance_from_globalBest_for_neighborhood = 0.1;
    neighborhood_of_globalBest_particle = 2;
    initial_neighborhood = 5;
    rate_change_neighborhood = 0.3;
    lowerBound_of_neighborhood = 0.5;
    upperBound_of_neighborhood = 10;
    FitnessHistory_window_ChangeNeighbourhood = 5;
elseif bounds_of_search(2) == 5
    Number_of_iterations_in_LocalSearch = 30;
    lowerBound_of_iterationLocalSearch = 10;
    fraction_of_particles_close_to_sea_edge = 0.5;
    fraction_of_distance_from_globalBest_for_neighborhood = 0.1;
    neighborhood_of_globalBest_particle = 2;
    initial_neighborhood = 0.3;  %----------
    rate_change_neighborhood = 0.3;
    lowerBound_of_neighborhood = 0.01;  %----------
    upperBound_of_neighborhood = 1;  %----------
    FitnessHistory_window_ChangeNeighbourhood = 5;
elseif bounds_of_search(2) == 1  %--> bound [-3,1]
    Number_of_iterations_in_LocalSearch = 30;
    lowerBound_of_iterationLocalSearch = 10;
    fraction_of_particles_close_to_sea_edge = 0.5;
    fraction_of_distance_from_globalBest_for_neighborhood = 0.1;
    neighborhood_of_globalBest_particle = 2;
    initial_neighborhood = 0.1;  %----------
    rate_change_neighborhood = 0.3;
    lowerBound_of_neighborhood = 0.001;  %----------
    upperBound_of_neighborhood = 0.2;  %----------
    FitnessHistory_window_ChangeNeighbourhood = 5;
elseif bounds_of_search(2) == 0.5
    Number_of_iterations_in_LocalSearch = 30;
    lowerBound_of_iterationLocalSearch = 10;
    fraction_of_particles_close_to_sea_edge = 0.5;
    fraction_of_distance_from_globalBest_for_neighborhood = 0.1;
    neighborhood_of_globalBest_particle = 2;
    initial_neighborhood = 0.0001;  %----------
    rate_change_neighborhood = 0.3;
    lowerBound_of_neighborhood = 0.0001;  %----------
    upperBound_of_neighborhood = 0.1;  %----------
    FitnessHistory_window_ChangeNeighbourhood = 5;
elseif bounds_of_search(2) == inf
    if initialization_range(2) == 600
        Number_of_iterations_in_LocalSearch = 30;
        lowerBound_of_iterationLocalSearch = 10;
        fraction_of_particles_close_to_sea_edge = 0.5;
        fraction_of_distance_from_globalBest_for_neighborhood = 0.1;
        neighborhood_of_globalBest_particle = 2;
        initial_neighborhood = 5;
        rate_change_neighborhood = 0.3;
        lowerBound_of_neighborhood = 0.5;
        upperBound_of_neighborhood = 10;
        FitnessHistory_window_ChangeNeighbourhood = 5;
    elseif initialization_range(2) == 5
        Number_of_iterations_in_LocalSearch = 30;
        lowerBound_of_iterationLocalSearch = 10;
        fraction_of_particles_close_to_sea_edge = 0.5;
        fraction_of_distance_from_globalBest_for_neighborhood = 0.1;
        neighborhood_of_globalBest_particle = 2;
        initial_neighborhood = 0.3;  %----------
        rate_change_neighborhood = 0.3;
        lowerBound_of_neighborhood = 0.01;  %----------
        upperBound_of_neighborhood = 1;  %----------
        FitnessHistory_window_ChangeNeighbourhood = 5;
    end
end
%%%%%%% Actual global optima:
[actual_global_optima_location, actual_global_optima_fitness] = get_global_optima(function_landscape, Number_of_dimensions_of_landscape);
%%%%%%% Multiple runs of algorithm:
run = 22; % 0;
while run <= Number_of_runs - 1
    run = run + 1;
    str = sprintf('Function: %d, Run: %d', function_landscape, run);
    disp(str);
    %%%%%% Perform PMSO Algorithm:
    [bestFitnessLocation, bestFitness] = PMSO(function_landscape, Number_of_particles);
    %%%%%% if it was stuck, we should do this iteration again:
    if isempty(bestFitnessLocation) && isempty(bestFitness)
        run = run - 1;
        clc
        continue
    end
    %%%%%% Store results:
    error = bestFitness - actual_global_optima_fitness;
    errors(run) = error;
    path_save = sprintf('./saved_results/function_benchmark=%d', function_landscape);
    cd(path_save)
    save errors.mat errors
    cd('..')
    cd('..')
    clc
end
%%%%%% finding the best (least) error:
best_error = min(errors);
%%%%%% Averaging errors of runs:
mean_error = mean(errors);
%%%%%% finding the standard deviation of runs:
standard_deviation_error = sqrt(var(errors));

%% Saving results:
path_save = sprintf('./saved_results/function_benchmark=%d', function_landscape);
cd(path_save)
save errors.mat errors
save best_error.mat best_error
save mean_error.mat mean_error
save standard_deviation_error.mat standard_deviation_error
cd('..')
cd('..')

%% display results:
disp('best_error: '); disp(best_error);
disp('mean_error: '); disp(mean_error);
disp('standard_deviation_error: '); disp(standard_deviation_error);
end


