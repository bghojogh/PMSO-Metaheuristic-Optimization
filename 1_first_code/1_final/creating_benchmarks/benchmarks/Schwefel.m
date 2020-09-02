function y = Schwefel(x)
    % The number of variables n should be adjusted below.
    % The default value of n =2.
    %
    n = 2;   % n=2 means that X and Y
    s = 0;
    for j = 1:n
        s = s + x(j)*sin(sqrt(abs(x(j))));
    end
    y = 418.982*n - s;
end