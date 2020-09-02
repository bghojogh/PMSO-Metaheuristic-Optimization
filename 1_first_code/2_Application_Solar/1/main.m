%%
clc
clear 
close all

%% Settings of solar array:
number_of_columns = 9;
number_of_rows = 9;

%% draw the initial sollar array:
k_of_cells = [0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9;...
            0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9;...
            0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9;...
            0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9;...
            0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9;...
            0.6, 0.6, 0.6, 0.6, 0.6, 0.9, 0.9, 0.9, 0.9;...
            0.6, 0.6, 0.6, 0.4, 0.4, 0.4, 0.2, 0.2, 0.2;...
            0.6, 0.6, 0.6, 0.4, 0.4, 0.4, 0.2, 0.2, 0.2;...
            0.6, 0.6, 0.6, 0.4, 0.4, 0.4, 0.2, 0.2, 0.2];
figure
Draw_solar_array(k_of_cells, number_of_rows, number_of_columns);
set(gca,'xtick',[],'ytick',[])  % hide axes's numbers

%% plot the power of initial solar array:
figure
do_plot_the_power = 1;
Fitness = CostFunction(k_of_cells, do_plot_the_power);
title('The TST Structure');
xlabel('Array Volateg (volts)');
ylabel('Array Poer Output (W)');

%% SA Parameters
MaxIt=100;      % Maximum Number of Iterations
MaxIt2=1;      % Maximum Number of Inner Iterations
GammarusNum = 5;
neighborhoodLocalSearch = 1;

%% Initialization
% Create Initial Solution randomly
Gammarus_position = zeros(number_of_rows, number_of_columns, GammarusNum);
for GammarusIndex = 1:GammarusNum
    for j = 1:number_of_columns
        Gammarus_position(:,j,GammarusIndex) = randperm(number_of_rows)';
    end
end

% Array to Hold Best Cost Values
BestFitness=zeros(MaxIt,1);

%% PMSO Main Loop:
for it=1:MaxIt
    for GammarusIndex = 1:GammarusNum
        % set locations:
        if it ~= 1
            farest_distance = sqrt(sum(ones(number_of_rows,1).^2));
            for column = 1:number_of_columns
                for row = 1:number_of_rows
                    if Gammarus_position(row,column,GammarusIndex) == BestSol_Position(row,column)
                        column_equal_status(row) = 0;
                    else
                        column_equal_status(row) = 1;
                    end
                end
                distance_to_global_best(column) = sqrt(sum(column_equal_status.^2));
                distance_to_global_best(column) = distance_to_global_best(column) / farest_distance;
            end
            for column = 1:number_of_columns
                for row = 1:number_of_rows
                    if rand < distance_to_global_best(column)
                        wave_limit = round(9 * distance_to_global_best(column));
                        wave = round(-wave_limit + (wave_limit+wave_limit)*rand);    % in the limit of [wave_limit, wave_limit]
                        if row + wave < 1
                            what_row_to_be_transmitted_to = (row + wave) + number_of_rows;
                        elseif row + wave > number_of_rows
                            what_row_to_be_transmitted_to = 0 + ((row + wave) - number_of_rows);
                        else
                            what_row_to_be_transmitted_to = row + wave;
                        end
                        % swap the two rows:
                        temp = Gammarus_position(row,column,GammarusIndex);
                        Gammarus_position(row,column,GammarusIndex) = Gammarus_position(what_row_to_be_transmitted_to,column,GammarusIndex);
                        Gammarus_position(what_row_to_be_transmitted_to,column,GammarusIndex) = temp;
                    end
                end
            end
        end

        % Local Search:
        for Local_search_index = 1:MaxIt2
            position_to_search_at = Gammarus_position(:,:,:);
            for column = 1:number_of_columns
                for row = 1:number_of_rows
                    if rand < 0.35
                        search_limit = neighborhoodLocalSearch;
                        search_step = round(-search_limit + (search_limit+search_limit)*rand);    % in the limit of [search_limit, search_limit]
                        if row + search_step < 1
                            what_row_to_be_transmitted_to = (row + search_step) + number_of_rows;
                        elseif row + search_step > number_of_rows
                            what_row_to_be_transmitted_to = 0 + ((row + search_step) - number_of_rows);
                        else
                            what_row_to_be_transmitted_to = row + search_step;
                        end
                        % swap the two rows:
                        temp = position_to_search_at(row,column,GammarusIndex);
                        position_to_search_at(row,column,GammarusIndex) = position_to_search_at(what_row_to_be_transmitted_to,column,GammarusIndex);
                        position_to_search_at(what_row_to_be_transmitted_to,column,GammarusIndex) = temp;
                    end
                end
            end
            
            % calculate the k_of_cells:
            for column = 1:number_of_columns
                for row = 1:number_of_rows
                    k_of_cells_search(row,column) = k_of_cells(position_to_search_at(row,column,GammarusIndex), column);
                end
            end
            
            % calculate the fitness:
            do_plot_the_power = 0;
            Fitness = CostFunction(k_of_cells_search, do_plot_the_power);
            
            % Update Best Solution:
            if it == 1 && GammarusIndex == 1 && Local_search_index == 1
                BestSol_Position = position_to_search_at;
                BestSol_Fitness = Fitness;
                BestSol_k_of_cells = k_of_cells_search;
            else
                if Fitness >= BestSol_Fitness
                    BestSol_Position = position_to_search_at;
                    BestSol_Fitness = Fitness;
                    BestSol_k_of_cells = k_of_cells_search;
                end
            end
        end
    end

    % Store Best Cost
    BestFitness(it) = BestSol_Fitness;
    
    % Display Iteration Information
    disp(['Iteration ' num2str(it) ': Best Fitness = ' num2str(BestFitness(it))]);
    
    % Plot Solution
%     pause(0.01)
%     close all
%     do_plot_the_power = 1;
%     figure
%     Fitness = CostFunction(BestSol_k_of_cells, do_plot_the_power);
%     figure
%     Draw_solar_array(BestSol_k_of_cells, number_of_rows, number_of_columns);
end

%% Results
%%%% draw solar array:
figure
Draw_solar_array(BestSol_k_of_cells, number_of_rows, number_of_columns);
%%%% plot the Power:
do_plot_the_power = 1;
figure
Fitness = CostFunction(BestSol_k_of_cells, do_plot_the_power);
%%%% plot the fitness:
figure;
plot(BestFitness,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;