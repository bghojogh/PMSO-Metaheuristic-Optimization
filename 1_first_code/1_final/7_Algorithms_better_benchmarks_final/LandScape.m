function [x, z, step] = LandScape (landScapeCode)
    switch landScapeCode
        case 1
            step = 0.1;
            x_min = -100;
            x_max = 100;
            x = x_min:step:x_max;
            y = x;
            z = zeros(length(x),length(x));
            for i = 1:length(x)
                for j = 1:length(y)
                    z(i,j) = (x(i)^2) + (y(j)^2);
                end
            end
        case 2
            step = 0.1;
            x_min = -100;
            x_max = 100;
            x = x_min:step:x_max;
            y = x;
            z = zeros(length(x),length(x));
            [X,Y]=meshgrid(x,y);
            [row,col]=size(X);
            cd('./benchmarks');
            for l=1:col
                for h=1:row
                    z(h,l)=Griewank([X(h,l),Y(h,l)]);
                end
            end
            cd('..');
        case 3
            step = 0.1;
            x_min = -100;
            x_max = 100;
            x = x_min:step:x_max;
            y = x;
            z = zeros(length(x),length(x));
            [X,Y]=meshgrid(x,y);
            [row,col]=size(X);
            cd('./benchmarks');
            for l=1:col
                for h=1:row
                    z(h,l)=Schaffer([X(h,l),Y(h,l)]);
                end
            end
            cd('..');
        case 4
            step = 1;
            x_min = -500;
            x_max = 500;
            x = x_min:step:x_max;
            y = x;
            z = zeros(length(x),length(x));
            [X,Y]=meshgrid(x,y);
            [row,col]=size(X);
            cd('./benchmarks');
            for l=1:col
                for h=1:row
                    z(h,l)=Schwefel([X(h,l),Y(h,l)]);
                end
            end
            cd('..');
        case 5
            step = 0.1;
            x_min = -100;
            x_max = 100;
            x = x_min:step:x_max;
            y = x;
            z = zeros(length(x),length(x));
            [X,Y]=meshgrid(x,y);
            [row,col]=size(X);
            cd('./benchmarks');
            for l=1:col
                for h=1:row
                    z(h,l)=Moving_peaks_benchmark_scenario_1([X(h,l),Y(h,l)]);
                end
            end
            cd('..');
        otherwise
            error('Not valid landScapeCode!');
    end
end