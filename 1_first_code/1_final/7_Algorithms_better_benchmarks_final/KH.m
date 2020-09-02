%% Krill Herd (KH) Algorithm

%% MATLAB initializations:
clc
clear all
close all

%% Creating benchmark:
numberOfBenchmark = input('Please enter the number of Benchmark (1, 2, 3, 4 or 5): ');
[x, z, step] = LandScape (numberOfBenchmark);
x_min = min(x);
x_max = max(x);
y_min = x_min;
y_max = x_max;
y = x;
KrillsNumEntered = input('Please enter number of krills: ');
surf(x,y,z,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
xlabel('x');
ylabel('y');
zlabel('z');

%% Algorithm:
tic
%%%%%%% initializations:
GlobalIterationNum = 100;
KrillsNum = KrillsNumEntered;
GlobalBestCoordinate = zeros(2,1);
GlobalBestFitness = 0;
GlobalWorstFitness = 0;     %%%%%%%%%%%%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
LocalBestCoordinate = zeros(2,KrillsNum);  %%%%%%%%%%%%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
LocalBestFitness = zeros(1,KrillsNum);              %%%%%%%%%%%%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
iterationLocalSearch = 30;
neighborhoodLocalSearch = 15;
KrillLoc(1,:) = round(x_min + (x_max - x_min)*rand(1,KrillsNum));
KrillLoc(2,:) = round(y_min + (y_max - y_min)*rand(1,KrillsNum));
KrillLocLastIteration = zeros(2,KrillsNum);
N_old = 0;         %%%%%%%%%%%%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
F_old = 0;          %%%%%%%%%%%%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


%%%%%%>>>>>>>>>>>>>>>>>> bekonam:
% 1- bala ha
% 2- update (decrease) kardan -> page 5 of Gandomi -> between Equations
% (16) and (17)
% 3- in PMSO and PSO -> Loc should not be round -> local search is ok but
% locations sholdn't be int too.

%%%%%%% initializations (for plotting):
bestFitnessArray = 0;
betterAnswerFoundFlag = 0;

%%%%%%% global iterations (after each end of all local searches):
for globalIteration = 1:GlobalIterationNum
    betterAnswerFoundFlag = 0;
    
    %%%%%%% job of every Particle:
    for i = 1:KrillsNum
        
        if globalIteration~=1
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% START OF updating locations of Particles:
            %%% Induced Movement:
            N_max = 0.1;  % maximum induced speed
            w_n = 0.5;  % inertia weight of the motion induced in the range [0,1]
            distance_to_other_krills = sqrt((KrillLoc(1,i) - KrillLoc(1,:)).^2 + (KrillLoc(2,i) - KrillLoc(2,:)).^2);
            sensing_distance = (1/(5*KrillsNum)) * sum(distance_to_other_krills);
            alpha_local = 0;
            for j = 1:KrillsNum    % finding neighbors
                if distance_to_other_krills(j) < sensing_distance
                    %%% the other krill is a neighbor
                    Epsilon = 0.001;
                    X_ij = (KrillLoc(:,i) - KrillLoc(:,j)) ./ (distance_to_other_krills(j) + Epsilon);
                    x_Loc_mapped = round(KrillLoc(1,i) / step) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
                    y_Loc_mapped = round(KrillLoc(2,i) / step) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
                    K_i = z(x_Loc_mapped, y_Loc_mapped);  % fitness of ith (this) krill
                    x_Loc_mapped = round(KrillLoc(1,j) / step) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
                    y_Loc_mapped = round(KrillLoc(2,j) / step) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
                    K_j = z(x_Loc_mapped, y_Loc_mapped);  % fitness of jth (neighbor) krill
                    K_ij = (K_i - K_j)/abs(GlobalWorstFitness - GlobalBestFitness);
                    alpha_local = alpha_local + (K_ij .* X_ij);
                end
            end
            C_best = 2 * (rand + (globalIteration / GlobalIterationNum));
            alpha_target = C_best * GlobalBestFitness * GlobalBestCoordinate;
            alpha = alpha_local + alpha_target;
            N = (N_max * alpha) + (w_n * N_old);

            %%% Foraging motion:
            V_f = 0.1;  % foraging speed
            w_f = 0.5;  % inertia weight of the foraging motion in the range [0,1]
            sum_in_numinator = 0;
            sum_in_denuminator = 0;
            for j = 1:KrillsNum    % finding X_food
                X_i = KrillLoc(:,i);
                x_Loc_mapped = round(KrillLoc(1,i) / step) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
                y_Loc_mapped = round(KrillLoc(2,i) / step) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
                K_i = z(x_Loc_mapped, y_Loc_mapped);  % fitness of ith krill
                sum_in_numinator = sum_in_numinator + (X_i / K_i);
                sum_in_denuminator = sum_in_denuminator + (1 / K_i);
            end
            X_food = sum_in_numinator / sum_in_denuminator;
            x_Loc_mapped = round(X_food(1,i) / step) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
            y_Loc_mapped = round(X_food(2,i) / step) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
            K_food = z(x_Loc_mapped, y_Loc_mapped);  % fitness of food
            C_food = 2 * (1 - (globalIteration / GlobalIterationNum));
            Beta_food = C_food * K_food * X_food;
            Beta_best = LocalBestFitness(i) * LocalBestCoordinate(:,i);
            Beta = Beta_food + Beta_best;
            F = (V_f * Beta) + (w_f * F_old);

            %%% Random Diffusion:
            D_max = 0.009;    % maximum diffusion speed -> range: [0.002, 0.010]
            Gamma = -1 + ((1 - (-1))*rand(2,1));
            D = D_max * (1 - (globalIteration / GlobalIterationNum)) * Gamma;

            %%% total motion:
            motion_vector = N + F + D;
            KrillLoc(:,i) = KrillLoc(:,i) + motion_vector;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END OF updating locations of Particles
        end
        
        %%%%%%% Collision check:
        j = 1;
        while j <= KrillsNum
            if j~=i
                if (abs(KrillLoc(1,j)-KrillLoc(1,i))<=neighborhoodLocalSearch ...
                    && abs(KrillLoc(2,j)-KrillLoc(2,i))<=neighborhoodLocalSearch)
                    % Collision occured
                    if globalIteration~=1
                        KrillLoc(1,i) = KrillLocLastIteration(1,i);
                        KrillLoc(2,i) = KrillLocLastIteration(2,i);
                        while 1
                            
                            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% START OF updating locations of Particles:
                            %%% Induced Movement:
                            N_max = 0.1;  % maximum induced speed
                            w_n = 0.5;  % inertia weight of the motion induced in the range [0,1]
                            distance_to_other_krills = sqrt((KrillLoc(1,i) - KrillLoc(1,:)).^2 + (KrillLoc(2,i) - KrillLoc(2,:)).^2);
                            sensing_distance = (1/(5*KrillsNum)) * sum(distance_to_other_krills);
                            alpha_local = 0;
                            for j = 1:KrillsNum    % finding neighbors
                                if distance_to_other_krills(j) < sensing_distance
                                    %%% the other krill is a neighbor
                                    Epsilon = 0.001;
                                    X_ij = (KrillLoc(:,i) - KrillLoc(:,j)) ./ (distance_to_other_krills(j) + Epsilon);
                                    x_Loc_mapped = round(KrillLoc(1,i) / step) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
                                    y_Loc_mapped = round(KrillLoc(2,i) / step) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
                                    K_i = z(x_Loc_mapped, y_Loc_mapped);  % fitness of ith (this) krill
                                    x_Loc_mapped = round(KrillLoc(1,j) / step) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
                                    y_Loc_mapped = round(KrillLoc(2,j) / step) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
                                    K_j = z(x_Loc_mapped, y_Loc_mapped);  % fitness of jth (neighbor) krill
                                    K_ij = (K_i - K_j)/abs(GlobalWorstFitness - GlobalBestFitness);
                                    alpha_local = alpha_local + (K_ij .* X_ij);
                                end
                            end
                            C_best = 2 * (rand + (globalIteration / GlobalIterationNum));
                            alpha_target = C_best * GlobalBestFitness * GlobalBestCoordinate;
                            alpha = alpha_local + alpha_target;
                            N = (N_max * alpha) + (w_n * N_old);

                            %%% Foraging motion:
                            V_f = 0.1;  % foraging speed
                            w_f = 0.5;  % inertia weight of the foraging motion in the range [0,1]
                            sum_in_numinator = 0;
                            sum_in_denuminator = 0;
                            for j = 1:KrillsNum    % finding X_food
                                X_i = KrillLoc(:,i);
                                x_Loc_mapped = round(KrillLoc(1,i) / step) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
                                y_Loc_mapped = round(KrillLoc(2,i) / step) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
                                K_i = z(x_Loc_mapped, y_Loc_mapped);  % fitness of ith krill
                                sum_in_numinator = sum_in_numinator + (X_i / K_i);
                                sum_in_denuminator = sum_in_denuminator + (1 / K_i);
                            end
                            X_food = sum_in_numinator / sum_in_denuminator;
                            x_Loc_mapped = round(X_food(1,i) / step) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
                            y_Loc_mapped = round(X_food(2,i) / step) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
                            K_food = z(x_Loc_mapped, y_Loc_mapped);  % fitness of food
                            C_food = 2 * (1 - (globalIteration / GlobalIterationNum));
                            Beta_food = C_food * K_food * X_food;
                            Beta_best = LocalBestFitness(i) * LocalBestCoordinate(:,i);
                            Beta = Beta_food + Beta_best;
                            F = (V_f * Beta) + (w_f * F_old);

                            %%% Random Diffusion:
                            D_max = 0.009;    % maximum diffusion speed -> range: [0.002, 0.010]
                            Gamma = -1 + ((1 - (-1))*rand(2,1));
                            D = D_max * (1 - (globalIteration / GlobalIterationNum)) * Gamma;

                            %%% total motion:
                            motion_vector = N + F + D;
                            TempLoc(:,i) = KrillLoc(:,i) + motion_vector;
                            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END OF updating locations of Particles

                            if (TempLoc(1,i) >= x_min && TempLoc(1,i) <= x_max ...
                                 && TempLoc(2,i) >= y_min && TempLoc(2,i) <= y_max)
                                    KrillLoc = TempLoc;
                                    break
                            end
                        end
                    else
                        KrillLoc(1,i) = floor((x_min + (x_max - x_min)*rand) * (1/step)) / (1/step);  % (floor(number*(1/step))/(1/step)) --> truncates precision of number to step size --> example: step=10 -> precision of number is 0.1
                        KrillLoc(2,i) = floor((y_min + (y_max - y_min)*rand) * (1/step)) / (1/step);
                    end
                    j = 1;
                    continue  %% check for this Gammarus another time.
                end
            end
            j = j + 1;
        end
        
        %%%%%%% Local Search:
        for k = 1:iterationLocalSearch
            if KrillLoc(1,i) - neighborhoodLocalSearch < x_min
                x_rand_min = x_min;
            else
                x_rand_min = KrillLoc(1,i) - neighborhoodLocalSearch;
            end
            if KrillLoc(1,i) + neighborhoodLocalSearch > x_max
                x_rand_max = x_max;
            else
                x_rand_max = KrillLoc(1,i) + neighborhoodLocalSearch;
            end
            if KrillLoc(2,i) - neighborhoodLocalSearch < y_min
                y_rand_min = y_min;
            else
                y_rand_min = KrillLoc(2,i) - neighborhoodLocalSearch;
            end
            if KrillLoc(2,i) + neighborhoodLocalSearch > y_max
                y_rand_max = y_max;
            else
                y_rand_max = KrillLoc(2,i) + neighborhoodLocalSearch;
            end
            x_rand = floor((x_rand_min + (x_rand_max - x_rand_min)*rand) * (1/step)) / (1/step);  % (floor(number*(1/step))/(1/step)) --> truncates precision of number to step size --> example: step=10 -> precision of number is 0.1
            y_rand = floor((y_rand_min + (y_rand_max - y_rand_min)*rand) * (1/step)) / (1/step);
            x_rand_mapped = round(x_rand / step) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
            y_rand_mapped = round(y_rand / step) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
            fitness = z(x_rand_mapped, y_rand_mapped); 
            %%% updating global best:
            if (globalIteration == 1 && i == 1 && k == 1) %% if first particle in first iteration of all
                GlobalBestFitness = fitness;
                GlobalBestCoordinate = [x_rand; y_rand];
                time_betterSolutionFound = toc;
                %%%% for plot:
                bestFitnessArray = [GlobalBestFitness; GlobalBestCoordinate; globalIteration];
                betterAnswerFoundFlag = 1;
            elseif fitness < GlobalBestFitness
                GlobalBestFitness = fitness;
                GlobalBestCoordinate = [x_rand; y_rand];
                time_betterSolutionFound = toc;
                %%%% for plot:
                bestFitnessArray = [bestFitnessArray [GlobalBestFitness; GlobalBestCoordinate; globalIteration]];
                betterAnswerFoundFlag = 1;
            end
            %%% updating local best:
            if (globalIteration == 1 && k == 1) %% if first local search of particle i, in first iteration of all
                LocalBestFitness = fitness;
                LocalBestCoordinate(:,i) = [x_rand; y_rand];
            elseif fitness < LocalBestFitness
                LocalBestFitness = fitness;
                LocalBestCoordinate(:,i) = [x_rand; y_rand];
            end
        end
        
    end
    KrillLocLastIteration = KrillLoc;
    
    %%%%%%% plotting Particles and better Solution on the land scape, when a better solution is found:
    %%% plotting Particles
    if betterAnswerFoundFlag == 1
        figure
        surf(x,y,z,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
        xlabel('x');
        ylabel('y');
        zlabel('z');
        view(0, 90);  % view the surface from directly overhead
        hold on
        for index = 1:KrillsNum
            x_mapped = round(KrillLoc(1,index) / step) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
            y_mapped = round(KrillLoc(2,index) / step) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
            Point = z(x_mapped,y_mapped) + 100000;
            plot3(KrillLoc(1,index),KrillLoc(2,index),Point,'ow', 'MarkerSize', 10, 'MarkerFaceColor', [1,1,1]);
        end
        %%% plotting better Solution
        x_mapped = round(GlobalBestCoordinate(1,1)) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
        y_mapped = round(GlobalBestCoordinate(2,1)) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
        Point = z(x_mapped,y_mapped) + 1000;
        plot3(GlobalBestCoordinate(1,1),GlobalBestCoordinate(2,1),Point,'hw', 'MarkerSize', 10, 'MarkerFaceColor', [1,1,1]);
        %%% title of plot
        str = sprintf('Better Solution found in iteration: %d\nBetter Solution: %f\nLocation of better solution: (%.3f;%.3f)\ntime: %f seconds', ...
                        globalIteration, GlobalBestFitness, GlobalBestCoordinate(1,1), GlobalBestCoordinate(2,1), time_betterSolutionFound);
        title(str);
        %legend('Particle', 'Better Solution');
        hold off
    end
    
end % (Error <= 0.1 || iterationNum == 50)  --> should we put error, too? -> I don't think so!

%% Plotting results:
figure
plot([bestFitnessArray(4,:) ,GlobalIterationNum], [bestFitnessArray(1,:), bestFitnessArray(1,length(bestFitnessArray(1,:)))]);
str = sprintf('best fittness found: %f\nbest fitness coordinate found: (%.3f;%.3f)\nbest fitness found in iteration number: %d\nbest fitness found in time: %f seconds', ...
                GlobalBestFitness, GlobalBestCoordinate(1,1), GlobalBestCoordinate(2,1), bestFitnessArray(4,length(bestFitnessArray(4,:))), time_betterSolutionFound);
disp(str);
title(str);
xlabel('number of iterations');
ylabel('best (least) found fitness value');

