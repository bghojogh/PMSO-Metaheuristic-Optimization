function [x, z, step, min_of_z, x_of_min_of_z, y_of_min_of_z] = LandScape (landScapeCode, Dimension)
    switch landScapeCode
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
        otherwise
            error('Not valid landScapeCode!');
    end
end
