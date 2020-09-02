%% Particle Swarm Optimization (PSO) Algorithm
function [time_betterSolutionFound, bestFitnessArray] = PSO(x,y,z, ParticlesNum, step, initial_Location, GlobalIterationNum, disp_figures_and_results)

tic
%%%%%%% initializations:
x_min = min(x);
x_max = max(x);
y_min = min(y);
y_max = max(y);
GlobalBestCoordinate = zeros(2,1);
GlobalBestFitness = 0;
iterationLocalSearch = 30;
neighborhoodLocalSearch = 15;
ParticleLoc(1,:) = initial_Location(1,:);
ParticleLoc(2,:) = initial_Location(2,:);
ParticleLocLastIteration = zeros(2,ParticlesNum);
LocalBestCoordinate = zeros(2,ParticlesNum);  % Particle Best till now (nostalgy)
LocalBestFitness = 0;
c1 = 0.25;
c2 = 0.75;
V_t = zeros(2,1);  % initial V_t

%%%%%%% initializations (for plotting):
bestFitnessArray = 0;
betterAnswerFoundFlag = 0;

%%%%%%% global iterations (after each end of all local searches):
for globalIteration = 1:GlobalIterationNum
    betterAnswerFoundFlag = 0;
    
    %%%%%%% job of every Particle:
    for i = 1:ParticlesNum
        
        %%%%%%% updating locations of Particles:
        if globalIteration~=1  
            ParticleVectorToGlobalBest(1,1) = GlobalBestCoordinate(1,1) - ParticleLoc(1,i);
            ParticleVectorToGlobalBest(2,1) = GlobalBestCoordinate(2,1) - ParticleLoc(2,i);
            ParticleVectorToLocalBest(1,1) = LocalBestCoordinate(1,i) - ParticleLoc(1,i);
            ParticleVectorToLocalBest(2,1) = LocalBestCoordinate(2,i) - ParticleLoc(2,i);
            while 1
                r1 = randn;  % first random number
                r2 = randn;  % second random number
                V_tPlus1 = V_t + ((c1 * r1) .* ParticleVectorToGlobalBest) + ((c2 * r2) .* ParticleVectorToLocalBest);
                x_temp = floor((ParticleLoc(1,i) + V_tPlus1(1,1)) * (1/step)) / (1/step);  % (floor(number*(1/step))/(1/step)) --> truncates precision of number to step size --> example: step=10 -> precision of number is 0.1
                y_temp = floor((ParticleLoc(2,i) + V_tPlus1(2,1)) * (1/step)) / (1/step);
                if (x_temp >= x_min && x_temp <= x_max ...
                     && y_temp >= y_min && y_temp <= y_max)
                        ParticleLoc(1,i) = x_temp;
                        ParticleLoc(2,i) = y_temp;
                        break
                end
            end
        end
        
        %%%%%%% Collision check:
        j = 1;
        while j <= ParticlesNum
            if j~=i
                if (abs(ParticleLoc(1,j)-ParticleLoc(1,i))<=neighborhoodLocalSearch ...
                    && abs(ParticleLoc(2,j)-ParticleLoc(2,i))<=neighborhoodLocalSearch)
                    % Collision occured
                    if globalIteration~=1
                        ParticleLoc(1,i) = ParticleLocLastIteration(1,i);
                        ParticleLoc(2,i) = ParticleLocLastIteration(2,i);
                        ParticleVectorToGlobalBest(1,1) = GlobalBestCoordinate(1,1) - ParticleLoc(1,i);
                        ParticleVectorToGlobalBest(2,1) = GlobalBestCoordinate(2,1) - ParticleLoc(2,i);
                        ParticleVectorToLocalBest(1,1) = LocalBestCoordinate(1,i) - ParticleLoc(1,i);
                        ParticleVectorToLocalBest(2,1) = LocalBestCoordinate(2,i) - ParticleLoc(2,i);
                        while 1
                            r1 = randn;  % first random number
                            r2 = randn;  % second random number
                            V_tPlus1 = V_t + ((c1 * r1) .* ParticleVectorToGlobalBest) + ((c2 * r2) .* ParticleVectorToLocalBest);
                            x_temp = floor((ParticleLoc(1,i) + V_tPlus1(1,1)) * (1/step)) / (1/step);  % (floor(number*(1/step))/(1/step)) --> truncates precision of number to step size --> example: step=10 -> precision of number is 0.1
                            y_temp = floor((ParticleLoc(2,i) + V_tPlus1(2,1)) * (1/step)) / (1/step);
                            if (x_temp >= x_min && x_temp <= x_max ...
                                 && y_temp >= y_min && y_temp <= y_max)
                                    ParticleLoc(1,i) = x_temp;
                                    ParticleLoc(2,i) = y_temp;
                                    break
                            end
                        end
                    else
                        ParticleLoc(1,i) = floor((x_min + (x_max - x_min)*rand) * (1/step)) / (1/step);  % (floor(number*(1/step))/(1/step)) --> truncates precision of number to step size --> example: step=10 -> precision of number is 0.1
                        ParticleLoc(2,i) = floor((y_min + (y_max - y_min)*rand) * (1/step)) / (1/step);
                    end
                    j = 1;
                    continue  %% check for this Gammarus another time.
                end
            end
            j = j + 1;
        end
        
        %%%%%%% Local Search:
        for k = 1:iterationLocalSearch
            if ParticleLoc(1,i) - neighborhoodLocalSearch < x_min
                x_rand_min = x_min;
            else
                x_rand_min = ParticleLoc(1,i) - neighborhoodLocalSearch;
            end
            if ParticleLoc(1,i) + neighborhoodLocalSearch > x_max
                x_rand_max = x_max;
            else
                x_rand_max = ParticleLoc(1,i) + neighborhoodLocalSearch;
            end
            if ParticleLoc(2,i) - neighborhoodLocalSearch < y_min
                y_rand_min = y_min;
            else
                y_rand_min = ParticleLoc(2,i) - neighborhoodLocalSearch;
            end
            if ParticleLoc(2,i) + neighborhoodLocalSearch > y_max
                y_rand_max = y_max;
            else
                y_rand_max = ParticleLoc(2,i) + neighborhoodLocalSearch;
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
    ParticleLocLastIteration = ParticleLoc;
    
    %%%%%%% plotting Particles and better Solution on the land scape, when a better solution is found:
    if disp_figures_and_results == 1
        %%% plotting Particles
        if betterAnswerFoundFlag == 1
            figure
            surf(x,y,z,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
            xlabel('x');
            ylabel('y');
            zlabel('z');
            view(0, 90);  % view the surface from directly overhead
            hold on
            for index = 1:ParticlesNum
                x_mapped = round(ParticleLoc(1,index) / step) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
                y_mapped = round(ParticleLoc(2,index) / step) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
                Point = z(x_mapped,y_mapped) + 100000;
                plot3(ParticleLoc(1,index),ParticleLoc(2,index),Point,'ow', 'MarkerSize', 10, 'MarkerFaceColor', [1,1,1]);
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
    end
    
end % (Error <= 0.1 || iterationNum == 50)  --> should we put error, too? -> I don't think so!

%% Plotting results:
if disp_figures_and_results == 1
    figure
    plot([bestFitnessArray(4,:) ,GlobalIterationNum], [bestFitnessArray(1,:), bestFitnessArray(1,length(bestFitnessArray(1,:)))]);
    str = sprintf('best fittness found: %f\nbest fitness coordinate found: (%.3f;%.3f)\nbest fitness found in iteration number: %d\nbest fitness found in time: %f seconds', ...
                    GlobalBestFitness, GlobalBestCoordinate(1,1), GlobalBestCoordinate(2,1), bestFitnessArray(4,length(bestFitnessArray(4,:))), time_betterSolutionFound);
    disp(str);
    title(str);
    xlabel('number of iterations');
    ylabel('best (least) found fitness value');
end

end