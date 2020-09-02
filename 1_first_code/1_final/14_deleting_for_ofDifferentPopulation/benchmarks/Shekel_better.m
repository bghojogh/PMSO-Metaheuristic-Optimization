function y = Shekel_better(x)
    % The number of variables n should be adjusted below.
    % The default value of n =2.
    %
    n = 2;   % n=2 means that X and Y
    m = 5;  % m is number of minimums
    C = 0.001 * [2 5 5 5 5]';
    A = [0.5 0.25 0.25 0.75 0.75;
         0.5 0.25 0.75 0.25 0.75];

    outer = 0;
    for i = 1:m
        inner = 0;
        for j = 1:n
            inner = inner + (x(j)-A(j, i))^2;
        end
        outer = outer + 1/(inner+C(i));
    end

    y = -outer;
end
