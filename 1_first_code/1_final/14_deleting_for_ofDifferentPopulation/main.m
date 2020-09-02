%% Comparing Optimization Algorithms:

%% MATLAB initializations:
clc
clear all
close all

%% initializations:
GlobalIterationNum = 100;
disp_figures_and_results = 0;

%% Creating benchmark:
numberOfBenchmark = input('Please enter the number of Benchmark (1, 2, 3, 4 or 5): ');
[x, z, step, min_of_z, x_of_min_of_z, y_of_min_of_z] = LandScape (numberOfBenchmark);
x_min = min(x);
x_max = max(x);
y_min = x_min;
y_max = x_max;
y = x;
% PopulationNum = input('Please enter number of population individuals: ');
surf(x,y,z,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
xlabel('x');
ylabel('y');
zlabel('z');

%% taking number of particles:
numberOfParticles = input('Please enter number of particles: ');

%% multiple executions of algorithms:
start_of_i_for = numberOfParticles;
stop_of_i_for = numberOfParticles;
length_of_i_for = (stop_of_i_for - start_of_i_for) + 1;
initial_Location = zeros(2,stop_of_i_for,length_of_i_for);  % here, 2 is because of x and y
length_of_j_for = (5-1) + 1;
length_of_k_for = (5-1) + 1;
sum_bestFitnessCoordinate = zeros(2,3);
sum_time_betterSolutionFound = zeros(3,1);
sum_bestFitness = zeros(3,1);
sum_error = zeros(3,1);
fitness_plot_PMSO = zeros(2, GlobalIterationNum, length_of_i_for * length_of_j_for * length_of_k_for);  %% rows: x and y of plot (x: iteration, y: fitness) , colomns: iterations that better answer is found: at most (worst) in all iterations we have better answer , third dimension: each test on algorithm
fitness_plot_PSO = zeros(2, GlobalIterationNum, length_of_i_for * length_of_j_for * length_of_k_for);
fitness_plot_GA = zeros(2, GlobalIterationNum, length_of_i_for * length_of_j_for * length_of_k_for);
numberOfIterations_that_better_answer_found = zeros(3, length_of_i_for * length_of_j_for * length_of_k_for); %% 3 --> becuase we have 3 algorithms
counter2 = 1;

counter = 1;
for i = start_of_i_for:stop_of_i_for            %%% different numbers of population individuals
    PopulationNum = i;
    for j = 1:5                                 %%% different locations of population individuals
        disp('j: ');
        disp(j);
        disp(' ');
        %%% first random locations of population:
        initial_Location(1,1:i,counter) = round(x_min + (x_max - x_min)*rand(1,PopulationNum));
        initial_Location(2,1:i,counter) = round(y_min + (y_max - y_min)*rand(1,PopulationNum));
        for k = 1:5                             %%% different executions of algorithms
            disp('k: ');
            disp(k);
            disp(' ');
            %% PMSO:
            cd('./algorithms');
            [time_betterSolutionFound, bestFitnessArray] = PMSO(x,y,z, PopulationNum, step, initial_Location(:,1:i,counter), GlobalIterationNum, disp_figures_and_results);
            cd('..');
            sum_time_betterSolutionFound(1) = sum_time_betterSolutionFound(1) + time_betterSolutionFound;
            sum_bestFitnessCoordinate(:,1) = sum_bestFitnessCoordinate(:,1) + bestFitnessArray(2:3, size(bestFitnessArray,2));  %% size(bestFitnessArray,2) is because we want the last best fitness found
            sum_bestFitness(1) = sum_bestFitness(1) + bestFitnessArray(1, size(bestFitnessArray,2));
            sum_error(1) = sum_error(1) + sqrt((bestFitnessArray(2, size(bestFitnessArray,2)) - x_of_min_of_z)^2 + (bestFitnessArray(3, size(bestFitnessArray,2)) - y_of_min_of_z)^2);
            fitness_plot_PMSO(:,1:size(bestFitnessArray,2),counter2) = [bestFitnessArray(4,:) ; bestFitnessArray(1,:)];
            numberOfIterations_that_better_answer_found(1,counter2) = size(bestFitnessArray,2);
            
            %% PSO:
            %close all
            cd('./algorithms');
            [time_betterSolutionFound, bestFitnessArray] = PSO(x,y,z, PopulationNum, step, initial_Location(:,1:i,counter), GlobalIterationNum, disp_figures_and_results);
            cd('..');
            sum_time_betterSolutionFound(2) = sum_time_betterSolutionFound(2) + time_betterSolutionFound;
            sum_bestFitnessCoordinate(:,2) = sum_bestFitnessCoordinate(:,2) + bestFitnessArray(2:3, size(bestFitnessArray,2));  %% size(bestFitnessArray,2) is because we want the last best fitness found
            sum_bestFitness(2) = sum_bestFitness(2) + bestFitnessArray(1, size(bestFitnessArray,2));
            sum_error(2) = sum_error(2) + sqrt((bestFitnessArray(2, size(bestFitnessArray,2)) - x_of_min_of_z)^2 + (bestFitnessArray(3, size(bestFitnessArray,2)) - y_of_min_of_z)^2);
            fitness_plot_PSO(:,1:size(bestFitnessArray,2),counter2) = [bestFitnessArray(4,:) ; bestFitnessArray(1,:)];
            numberOfIterations_that_better_answer_found(2,counter2) = size(bestFitnessArray,2);

            %% GA:
            %close all
            cd('./algorithms');
            [time_betterSolutionFound, bestFitnessArray] = GA(x,y,z, PopulationNum, step, initial_Location(:,1:i,counter), GlobalIterationNum, disp_figures_and_results);
            cd('..');
            sum_time_betterSolutionFound(3) = sum_time_betterSolutionFound(3) + time_betterSolutionFound;
            sum_bestFitnessCoordinate(:,3) = sum_bestFitnessCoordinate(:,3) + bestFitnessArray(2:3, size(bestFitnessArray,2));  %% size(bestFitnessArray,2) is because we want the last best fitness found
            sum_bestFitness(3) = sum_bestFitness(3) + bestFitnessArray(1, size(bestFitnessArray,2));
            sum_error(3) = sum_error(3) + sqrt((bestFitnessArray(2, size(bestFitnessArray,2)) - x_of_min_of_z)^2 + (bestFitnessArray(3, size(bestFitnessArray,2)) - y_of_min_of_z)^2);
            fitness_plot_GA(:,1:size(bestFitnessArray,2),counter2) = [bestFitnessArray(4,:) ; bestFitnessArray(1,:)];
            numberOfIterations_that_better_answer_found(3,counter2) = size(bestFitnessArray,2);
            
            %%
            counter2 = counter2 + 1;
        end
    end
    counter = counter + 1;
end

%% displaying errors and time:
Total_error = sum_error ./ (length_of_i_for * length_of_j_for * length_of_k_for);
disp('Errors:');
disp(Total_error);

% Average_time = sum_time_betterSolutionFound ./ (length_of_i_for * length_of_j_for * length_of_k_for);
% disp('Average time:');
% disp(Average_time);

%% plotting mean of plots:
%%% equaling length of fitness_plot_PMSO for all testings (so we can take a mean of them), and also ending the plots to GlobalIterationNum:
%%% Notice: for taking mean of plots in MATLAB, number of points should be the same, but x of points can be different! 
for j=1:length_of_i_for * length_of_j_for * length_of_k_for
    for i=1:max(numberOfIterations_that_better_answer_found(1,:))+1  % max + 1 --> because we want to end all of them in GlobalIterationNum
        if fitness_plot_PMSO(1,i,j) == 0
            fitness_plot_PMSO(1,i:GlobalIterationNum,j) = GlobalIterationNum;
            fitness_plot_PMSO(2,i:GlobalIterationNum,j) = fitness_plot_PMSO(2,i-1,j);
            break;
        end
    end
end

for j=1:length_of_i_for * length_of_j_for * length_of_k_for
    for i=1:max(numberOfIterations_that_better_answer_found(2,:))+1  % max + 1 --> because we want to end all of them in GlobalIterationNum
        if fitness_plot_PSO(1,i,j) == 0
            fitness_plot_PSO(1,i:GlobalIterationNum,j) = GlobalIterationNum;
            fitness_plot_PSO(2,i:GlobalIterationNum,j) = fitness_plot_PSO(2,i-1,j);
            break;
        end
    end
end

for j=1:length_of_i_for * length_of_j_for * length_of_k_for
    for i=1:max(numberOfIterations_that_better_answer_found(3,:))+1  % max + 1 --> because we want to end all of them in GlobalIterationNum
        if fitness_plot_GA(1,i,j) == 0
            fitness_plot_GA(1,i:GlobalIterationNum,j) = GlobalIterationNum;
            fitness_plot_GA(2,i:GlobalIterationNum,j) = fitness_plot_GA(2,i-1,j);
            break;
        end
    end
end

%%%%% taking mean of plots, for each algorithm:
biggest_numberOfIterations_that_better_answer_found = max(numberOfIterations_that_better_answer_found, [], 2);
%%% for PMSO:
figure
hold on
for j=1:length_of_i_for * length_of_j_for * length_of_k_for 
    plot(fitness_plot_PMSO(1,:,j), fitness_plot_PMSO(2,:,j));
end
hold off
title('PMSO');
plot_data = get(get(gca,'Children'),'YData'); % cell array of all "y" data of plots
average_PMSO = mean(cell2mat(plot_data));

%%% for PSO:
figure
hold on
for j=1:length_of_i_for * length_of_j_for * length_of_k_for 
    plot(fitness_plot_PSO(1,:,j), fitness_plot_PSO(2,:,j));
end
hold off
title('PSO');
plot_data = get(get(gca,'Children'),'YData'); % cell array of all "y" data of plots
average_PSO = mean(cell2mat(plot_data));

%%% for GA:
figure
hold on
for j=1:length_of_i_for * length_of_j_for * length_of_k_for 
    plot(fitness_plot_GA(1,:,j), fitness_plot_GA(2,:,j));
end
hold off
title('GA');
plot_data = get(get(gca,'Children'),'YData'); % cell array of all "y" data of plots
average_GA = mean(cell2mat(plot_data));

%%%%
figure
hold on
plot(average_PMSO, 'r', 'LineWidth',3);
plot(average_PSO, '--b', 'LineWidth',3);
plot(average_GA, ':k', 'LineWidth',3);
l = legend('PMSO', 'PSO', 'GA');
set(l, 'FontSize', 15);
a = min([min(average_PMSO), min(average_PSO), min(average_GA)]);
b = max([max(average_PMSO), max(average_PSO), max(average_GA)]);
ylim([a-((b-a)*0.05) , b+((b-a)*0.05)]);
str = sprintf('%d particles, benchmark: %d', numberOfParticles, numberOfBenchmark);
t = title(str);
set(t, 'Position',  [GlobalIterationNum/3, b-((b-a)*0.05)], 'FontSize', 13, 'fontweight','bold') ;
xlabel('No. Iterations', 'FontSize', 15);
ylabel('Average best so far', 'FontSize', 15);
box on
hold off

