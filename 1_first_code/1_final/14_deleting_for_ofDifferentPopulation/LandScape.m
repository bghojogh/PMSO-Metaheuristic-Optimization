function [x, z, step, min_of_z, x_of_min_of_z, y_of_min_of_z] = LandScape (landScapeCode)
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
                    if i == 1 && j == 1
                        min_of_z = z(i,j);
                        x_of_min_of_z = x(i);
                        y_of_min_of_z = y(j);
                    elseif z(i,j) < min_of_z
                        min_of_z = z(i,j);
                        x_of_min_of_z = x(i);
                        y_of_min_of_z = y(j);
                    end
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
                    if h == 1 && l == 1
                        min_of_z = z(h,l);
                        x_of_min_of_z = x(h);
                        y_of_min_of_z = y(l);
                    elseif z(h,l) < min_of_z
                        min_of_z = z(h,l);
                        x_of_min_of_z = x(h);
                        y_of_min_of_z = y(l);
                    end
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
                    if h == 1 && l == 1
                        min_of_z = z(h,l);
                        x_of_min_of_z = x(h);
                        y_of_min_of_z = y(l);
                    elseif z(h,l) < min_of_z
                        min_of_z = z(h,l);
                        x_of_min_of_z = x(h);
                        y_of_min_of_z = y(l);
                    end
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
                    if h == 1 && l == 1
                        min_of_z = z(h,l);
                        x_of_min_of_z = x(h);
                        y_of_min_of_z = y(l);
                    elseif z(h,l) < min_of_z
                        min_of_z = z(h,l);
                        x_of_min_of_z = x(h);
                        y_of_min_of_z = y(l);
                    end
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
                    if h == 1 && l == 1
                        min_of_z = z(h,l);
                        x_of_min_of_z = x(h);
                        y_of_min_of_z = y(l);
                    elseif z(h,l) < min_of_z
                        min_of_z = z(h,l);
                        x_of_min_of_z = x(h);
                        y_of_min_of_z = y(l);
                    end
                end
            end
            cd('..');
        otherwise
            error('Not valid landScapeCode!');
    end
end
