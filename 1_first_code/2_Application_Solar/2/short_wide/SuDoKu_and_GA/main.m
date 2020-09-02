%%
clc
clear 
close all

%% Settings of solar array:
number_of_columns = 9;
number_of_rows = 9;

%% Su Do Ku:

%%%%%% draw the initial sollar array:
k_of_cells = [0.9, 0.6, 0.9, 0.4, 0.6, 0.9, 0.9, 0.9, 0.2;...
            0.9, 0.9, 0.6, 0.6, 0.9, 0.4, 0.2, 0.9, 0.9;...
            0.9, 0.9, 0.6, 0.4, 0.9, 0.9, 0.2, 0.9, 0.9;...
            0.9, 0.9, 0.6, 0.9, 0.4, 0.9, 0.9, 0.2, 0.9;...
            0.9, 0.6, 0.9, 0.9, 0.9, 0.4, 0.9, 0.2, 0.9;...
            0.6, 0.6, 0.9, 0.9, 0.4, 0.9, 0.2, 0.9, 0.9;...
            0.6, 0.6, 0.9, 0.4, 0.9, 0.9, 0.9, 0.9, 0.2;...
            0.6, 0.9, 0.6, 0.9, 0.9, 0.4, 0.9, 0.2, 0.9;...
            0.6, 0.9, 0.9, 0.9, 0.4, 0.9, 0.9, 0.9, 0.2];
figure
Draw_solar_array(k_of_cells, number_of_rows, number_of_columns);
set(gca,'xtick',[],'ytick',[])  % hide axes's numbers

%%%%%% plot the power of initial solar array:
figure
do_plot_the_power = 1;
Fitness_SuDoKu = CostFunction(k_of_cells, do_plot_the_power);
%title('The Su Do Ku Structure');
xlabel('Array Volateg (volts)');
ylabel('Array Power Output (W)');
save k_of_cells_SuDoKu.mat k_of_cells

%% GA:

%%%%%% draw the initial sollar array:
k_of_cells = [0.9, 0.6, 0.9, 0.9, 0.4, 0.9, 0.2, 0.9, 0.9;...
            0.9, 0.6, 0.6, 0.9, 0.9, 0.4, 0.9, 0.2, 0.9;...
            0.9, 0.9, 0.9, 0.4, 0.4, 0.9, 0.9, 0.2, 0.9;...
            0.6, 0.9, 0.9, 0.4, 0.9, 0.9, 0.2, 0.9, 0.9;...
            0.9, 0.9, 0.6, 0.6, 0.4, 0.9, 0.9, 0.9, 0.2;...
            0.6, 0.6, 0.9, 0.4, 0.9, 0.9, 0.9, 0.2, 0.9;...
            0.6, 0.6, 0.6, 0.9, 0.9, 0.9, 0.9, 0.9, 0.2;...
            0.6, 0.9, 0.6, 0.9, 0.9, 0.4, 0.9, 0.9, 0.2;...
            0.9, 0.9, 0.9, 0.9, 0.6, 0.4, 0.2, 0.9, 0.9];
figure
Draw_solar_array(k_of_cells, number_of_rows, number_of_columns);
set(gca,'xtick',[],'ytick',[])  % hide axes's numbers

%%%%%% plot the power of initial solar array:
figure
do_plot_the_power = 1;
Fitness_GA = CostFunction(k_of_cells, do_plot_the_power);
%title('The Su Do Ku Structure');
xlabel('Array Volateg (volts)');
ylabel('Array Power Output (W)');
save k_of_cells_GA.mat k_of_cells

%% simple cell:
figure
Draw_solar_array_withoutText(k_of_cells, number_of_rows, number_of_columns);
set(gca,'xtick',[],'ytick',[])  % hide axes's numbers

