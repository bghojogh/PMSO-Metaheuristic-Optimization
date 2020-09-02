%% Pontogammarus Maeoticus Swarm Optimization (PMSO) Algorithm

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
GammarusNumEntered = input('Please enter number of Gammarus individuals: ');
surf(x,y,z,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
xlabel('x');
ylabel('y');
zlabel('z');
set(gcf, 'Color', [1 1 1]);  % backgroundcolor white

%% Algorithm:

tic
%%%%%%% initializations:
GlobalIterationNum = 100;
GammarusNum = GammarusNumEntered;
bestFitnessCoordinate = zeros(2,1);
bestFitness = 0;
iterationLocalSearch = 30;
neighborhoodLocalSearch = 15;   %% is related to SoftnessOfSand
GammarusLoc(1,:) = round(x_min + (x_max - x_min)*rand(1,GammarusNum));
GammarusLoc(2,:) = round(y_min + (y_max - y_min)*rand(1,GammarusNum));
GammarusLocLastIteration = zeros(2,GammarusNum);
WaveDisplacement = zeros(2,1);

%%%%%%% initializations (for plotting):
bestFitnessArray = 0;
betterAnswerFoundFlag = 0;

%%%%%%% global iterations (after each end of all local searches):
for globalIteration = 1:GlobalIterationNum
    betterAnswerFoundFlag = 0;
    
    %%%%%%% job of every Gammarus:
    for i = 1:GammarusNum
        
        %%%%%%% updating locations of Gammarus individuals:
        if globalIteration~=1  
            GammarusDistanceToSeaEdge = sqrt(((bestFitnessCoordinate(1,1)-GammarusLoc(1,i))^2) + ((bestFitnessCoordinate(2,1)-GammarusLoc(2,i))^2));
            while 1
                WaveDisplacement(1,1) = floor(((x_min + (x_max - x_min)*rand) * GammarusDistanceToSeaEdge) * (1/step)) / (1/step);  % (floor(number*(1/step))/(1/step)) --> truncates precision of number to step size --> example: step=10 -> precision of number is 0.1
                WaveDisplacement(2,1) = floor(((y_min + (y_max - y_min)*rand) * GammarusDistanceToSeaEdge) * (1/step)) / (1/step);
                if (GammarusLoc(1,i) + WaveDisplacement(1,1) >= x_min && GammarusLoc(1,i) + WaveDisplacement(1,1) <= x_max ...
                     && GammarusLoc(2,i) + WaveDisplacement(2,1) >= y_min && GammarusLoc(2,i) + WaveDisplacement(2,1) <= y_max)
                    GammarusLoc(1,i) = GammarusLoc(1,i) + WaveDisplacement(1,1);
                    GammarusLoc(2,i) = GammarusLoc(2,i) + WaveDisplacement(2,1);
                    break
                end
            end
        end
        
        %%%%%%% Collision check:
        j = 1;
        while j <= GammarusNum
            if j~=i
                if (abs(GammarusLoc(1,j)-GammarusLoc(1,i))<=neighborhoodLocalSearch ...
                    && abs(GammarusLoc(2,j)-GammarusLoc(2,i))<=neighborhoodLocalSearch)
                    % Collision occured
                    if globalIteration~=1
                        GammarusLoc(1,i) = GammarusLocLastIteration(1,i);
                        GammarusLoc(2,i) = GammarusLocLastIteration(2,i);
                        GammarusDistanceToSeaEdge = sqrt(((bestFitnessCoordinate(1,1)-GammarusLoc(1,i))^2) + ((bestFitnessCoordinate(2,1)-GammarusLoc(2,i))^2));
                        while 1
                            WaveDisplacement(1,1) = floor(((x_min + (x_max - x_min)*rand) * GammarusDistanceToSeaEdge) * (1/step)) / (1/step);  % (floor(number*(1/step))/(1/step)) --> truncates precision of number to step size --> example: step=10 -> precision of number is 0.1
                            WaveDisplacement(2,1) = floor(((y_min + (y_max - y_min)*rand) * GammarusDistanceToSeaEdge) * (1/step)) / (1/step);
                            if (GammarusLoc(1,i) + WaveDisplacement(1,1) >= x_min && GammarusLoc(1,i) + WaveDisplacement(1,1) <= x_max ...
                                 && GammarusLoc(2,i) + WaveDisplacement(2,1) >= y_min && GammarusLoc(2,i) + WaveDisplacement(2,1) <= y_max)
                                GammarusLoc(1,i) = GammarusLoc(1,i) + WaveDisplacement(1,1);
                                GammarusLoc(2,i) = GammarusLoc(2,i) + WaveDisplacement(2,1);
                                break
                            end
                        end
                    else
                          GammarusLoc(1,i) = floor((x_min + (x_max - x_min)*rand) * (1/step)) / (1/step);  % (floor(number*(1/step))/(1/step)) --> truncates precision of number to step size --> example: step=10 -> precision of number is 0.1
                          GammarusLoc(2,i) = floor((y_min + (y_max - y_min)*rand) * (1/step)) / (1/step);
                    end
                    j = 1;
                    continue  %% check for this Gammarus another time.
                end
            end
            j = j + 1;
        end
        
        %%%%%%% Local Search:
        for k = 1:iterationLocalSearch
            if GammarusLoc(1,i) - neighborhoodLocalSearch < x_min
                x_rand_min = x_min;
            else
                x_rand_min = GammarusLoc(1,i) - neighborhoodLocalSearch;
            end
            if GammarusLoc(1,i) + neighborhoodLocalSearch > x_max
                x_rand_max = x_max;
            else
                x_rand_max = GammarusLoc(1,i) + neighborhoodLocalSearch;
            end
            if GammarusLoc(2,i) - neighborhoodLocalSearch < y_min
                y_rand_min = y_min;
            else
                y_rand_min = GammarusLoc(2,i) - neighborhoodLocalSearch;
            end
            if GammarusLoc(2,i) + neighborhoodLocalSearch > y_max
                y_rand_max = y_max;
            else
                y_rand_max = GammarusLoc(2,i) + neighborhoodLocalSearch;
            end
            x_rand = floor((x_rand_min + (x_rand_max - x_rand_min)*rand) * (1/step)) / (1/step);  % (floor(number*(1/step))/(1/step)) --> truncates precision of number to step size --> example: step=10 -> precision of number is 0.1
            y_rand = floor((y_rand_min + (y_rand_max - y_rand_min)*rand) * (1/step)) / (1/step);
            x_rand_mapped = round(x_rand / step) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
            y_rand_mapped = round(y_rand / step) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
            fitness = z(x_rand_mapped, y_rand_mapped); 
            if (globalIteration == 1 && i == 1 && k == 1) %% if first gammarus in first iteration of all
                bestFitness = fitness;
                bestFitnessCoordinate = [x_rand; y_rand];
                time_betterSolutionFound = toc;
                %%%% for plot:
                bestFitnessArray = [bestFitness; bestFitnessCoordinate; globalIteration];
                betterAnswerFoundFlag = 1;
            elseif fitness < bestFitness
                bestFitness = fitness;
                bestFitnessCoordinate = [x_rand; y_rand];
                time_betterSolutionFound = toc;
                %%%% for plot:
                bestFitnessArray = [bestFitnessArray [bestFitness; bestFitnessCoordinate; globalIteration]];
                betterAnswerFoundFlag = 1;
            end
        end
        
    end
    GammarusLocLastIteration = GammarusLoc;
    
    %%%%%%% Decreasing iterationLocalSearch and neighborhoodLocalSearch (decreasing SoftnessOfSand) (Like Simulated Anealing):
    %%%% ------> I think it may be better if we comment this part!
    if iterationLocalSearch >= 10
        iterationLocalSearch = iterationLocalSearch - 1;
    end
    if neighborhoodLocalSearch >= 8
        neighborhoodLocalSearch = neighborhoodLocalSearch - 1;
    end
    
    %%%%%%% plotting Gammarus individuals and better Solution on the land scape, when a better solution is found:
    %%% plotting Gammarus individuals
    if betterAnswerFoundFlag == 1
        fig = figure;
%         set(fig, 'Color', [1 1 1]);  % backgroundcolor white
%         set(gcf,'PaperUnits','inches','PaperSize',[2,6],'PaperPosition',[0 0 2 6])
%         print('-dpng','-r100','test')
%         export_fig 'strip-diff-far-forward.png' -painters -nocrop
        surf(x,y,z,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
        xlabel('x');
        ylabel('y');
        zlabel('z');
        view(0, 90);  % view the surface from directly overhead
        hold on
        for index = 1:GammarusNum
            x_mapped = round(GammarusLoc(1,index) / step) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
            y_mapped = round(GammarusLoc(2,index) / step) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
            Point = z(x_mapped,y_mapped) + 100000;
            plot3(GammarusLoc(1,index),GammarusLoc(2,index),Point,'ow', 'MarkerSize', 10, 'MarkerFaceColor', [1,1,1]);
        end
        %%% plotting better Solution
        x_mapped = round(bestFitnessCoordinate(1,1)) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
        y_mapped = round(bestFitnessCoordinate(2,1)) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
        Point = z(x_mapped,y_mapped) + 1000;
        plot3(bestFitnessCoordinate(1,1),bestFitnessCoordinate(2,1),Point,'hw', 'MarkerSize', 10, 'MarkerFaceColor', [1,1,1]);
        %%% title of plot
        str = sprintf('Better Solution found in iteration: %d\nBetter Solution: %f\nLocation of better solution: (%.3f;%.3f)\ntime: %f seconds', ...
                        globalIteration, bestFitness, bestFitnessCoordinate(1,1), bestFitnessCoordinate(2,1), time_betterSolutionFound);
        title(str);
        %legend('Gammarus', 'Better Solution');
        hold off
        
%         set(0,'DefaultFigureColor','remove')
% set(gcf,'DefaultFigureColor',[0.5 0.5 0.5])  ----------> a dangarous instruction!!!!!
% set(0,'DefaultFigureColor','grey')
%         export_fig 'strip-diff-far-forward.png' -painters -nocrop
        set(gcf, 'Color', [1 1 1]);  % backgroundcolor white
% set(gcf, 'Color', 'None');
% set(gca, 'Color', 'None');
%         set(gcf, 'InvertHardCopy', 'on')
        
%         set(gcf, 'PaperPositionMode','auto')   
%         print(gcf, '-dpng','test.png', '-r0')
%         saveas(gcf,'test2','png')
%         backgroundColor = [0.5 0.5 0.5];
%         imwrite(gcf, 'a.png', 'png', 'transparency', backgroundColor)
    end
    
end % (Error <= 0.1 || iterationNum == 50)  --> should we put error, too? -> I don't think so!

%% Plotting results:
figure
plot([bestFitnessArray(4,:) ,GlobalIterationNum], [bestFitnessArray(1,:), bestFitnessArray(1,length(bestFitnessArray(1,:)))]);
str = sprintf('best fittness found: %f\nbest fitness coordinate found: (%.3f;%.3f)\nbest fitness found in iteration number: %d\nbest fitness found in time: %f seconds', ...
                bestFitness, bestFitnessCoordinate(1,1), bestFitnessCoordinate(2,1), bestFitnessArray(4,length(bestFitnessArray(4,:))), time_betterSolutionFound);
disp(str);
title(str);
xlabel('number of iterations');
ylabel('best (least) found fitness value');
set(gcf, 'Color', [1 1 1]);  % backgroundcolor white
