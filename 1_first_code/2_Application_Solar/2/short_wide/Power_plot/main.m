%%
clc
clear 
close all


%%
load k_of_cells_TCT
k_of_cells_TCT = k_of_cells;
load k_of_cells_SuDoKu
k_of_cells_SuDoKu = k_of_cells;
load k_of_cells_GA
k_of_cells_GA = k_of_cells;
load k_of_cells_PMSO
k_of_cells_PMSO = BestSol_k_of_cells;

%% plot the power of initial solar array:
figure
hold on
grid on
do_plot_the_power = 1;
[~, sorted_Va, Power_sorted] = CostFunction(k_of_cells_TCT, do_plot_the_power);
plot(sorted_Va, Power_sorted, '-*b');
[~, sorted_Va, Power_sorted] = CostFunction(k_of_cells_SuDoKu, do_plot_the_power);
plot(sorted_Va, Power_sorted, '-.>r');
[~, sorted_Va, Power_sorted] = CostFunction(k_of_cells_GA, do_plot_the_power);
plot(sorted_Va, Power_sorted, '--sg');
[~, sorted_Va, Power_sorted] = CostFunction(k_of_cells_PMSO, do_plot_the_power);
plot(sorted_Va, Power_sorted, '--ok');
%title('The Su Do Ku Structure');
xlabel('Array Volateg (volts)');
ylabel('Array Power Output (W)');
legend('TCT configuration','Su Do Ku configuration','GA algorithm', 'PMSO algorithm','Location','northwest');

