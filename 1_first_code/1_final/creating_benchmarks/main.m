%% Comparing Optimization Algorithms:

%% MATLAB initializations:
clc
clear all
close all

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
set(gcf, 'Color', [1 1 1]);  % backgroundcolor white
switch numberOfBenchmark
    case 1
        title('Sphere')
    case 2
        title('Griewank')
    case 3
        title('Schaffer')
    case 4
        title('Schwefel')
    case 5
        title('Moving Valleys')
end