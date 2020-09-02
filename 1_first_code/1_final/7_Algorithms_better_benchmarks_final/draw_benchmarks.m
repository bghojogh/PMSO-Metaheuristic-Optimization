clc
clear all
close all

%% Griewank:
figure
x = -100:0.1:100;
y=x;
[X,Y]=meshgrid(x,y);
[row,col]=size(X);
cd('./benchmarks');
for l=1:col
    for h=1:row
        z(h,l)=Griewank([X(h,l),Y(h,l)]);
    end
end
cd('..');
surf(X,Y,z);
shading interp

%% Rastrigin:
clear all
figure
%x = -100:0.1:100;
x = -6:0.01:6;
y=x;
[X,Y]=meshgrid(x,y);
[row,col]=size(X);
cd('./benchmarks');
for l=1:col
    for h=1:row
        z(h,l)=Rastrigin([X(h,l),Y(h,l)]);
    end
end
cd('..');
surf(X,Y,z);
shading interp

%% Schaffer:
clear all
figure
x = -100:0.1:100;
y=x;
[X,Y]=meshgrid(x,y);
[row,col]=size(X);
cd('./benchmarks');
for l=1:col
    for h=1:row
        z(h,l)=Schaffer([X(h,l),Y(h,l)]);
    end
end
cd('..');
surf(X,Y,z);
shading interp

%% Schwefel:
clear all
figure
x = -500:1:500;
y=x;
[X,Y]=meshgrid(x,y);
[row,col]=size(X);
cd('./benchmarks');
for l=1:col
    for h=1:row
        z(h,l)=Schwefel([X(h,l),Y(h,l)]);
    end
end
cd('..');
surf(X,Y,z);
shading interp

%% Shekel:
clear all
figure
x = 0:0.1:10;
y=x;
[X,Y]=meshgrid(x,y);
[row,col]=size(X);
cd('./benchmarks');
for l=1:col
    for h=1:row
        z(h,l)=Shekel([X(h,l),Y(h,l)]);
    end
end
cd('..');
surf(X,Y,z);
shading interp

%% Shekel_better:
clear all
figure
x = 0:0.001:1;
y=x;
[X,Y]=meshgrid(x,y);
[row,col]=size(X);
cd('./benchmarks');
for l=1:col
    for h=1:row
        z(h,l)=Shekel_better([X(h,l),Y(h,l)]);
    end
end
cd('..');
surf(X,Y,z);
shading interp

%% Moving_peaks_benchmark_scenario_1:
clear all
figure
x = -100:1:100;
y=x;
[X,Y]=meshgrid(x,y);
[row,col]=size(X);
cd('./benchmarks');
for l=1:col
    for h=1:row
        z(h,l)=Moving_peaks_benchmark_scenario_1([X(h,l),Y(h,l)]);
    end
end
cd('..');
surf(X,Y,z);
shading interp



