clc
clear all
close all

%%
x1 = [1 10 25 47 100];
y1 = [30 20 10 5 5];

% x2 = [1 36 58 80 100];
% y2 = [54 43 22 22 22];

x2 = [1 36 58 100 100];
y2 = [54 43 22 22 22];

figure
hold on
plot(x1, y1);
plot(x2, y2);
hold off

plot_data = get(get(gca,'Children'),'YData'); % cell array of all "y" data of plots
average = mean(cell2mat(plot_data));

figure
plot(average);