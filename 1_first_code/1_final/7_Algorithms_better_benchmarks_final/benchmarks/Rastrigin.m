function y = Rastrigin(x)
    %
    % The number of variables n should be adjusted below.
    % The default value of n =2.
    %
    n = 2;   % n=2 means that X and Y
    s = 0;
    for j = 1:n; s = s + x(j)^2 - 10*cos(2*pi*x(j)); end
    y = 10*n + s;
end
