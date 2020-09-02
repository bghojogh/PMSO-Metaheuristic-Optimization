function y = Schaffer(x)
    % The number of variables n should be adjusted below.
    % The default value of n =2.
    %
    n = 2;   % n=2 means that X and Y
    s = 0;
    for j = 1:n-1
        s = s + ((x(j)^2 + x(j+1)^2)^0.25 * (sin(50*(x(j)^2 + x(j+1)^2)^0.1)^2 + 1));
    end
    y = s;
end