function y = Shekel(x)
    % The number of variables n should be adjusted below.
    % The default value of n =2.
    %
    n = 2;   % n=2 means that X and Y
    m = 10;  % m is number of minimums
    b = 0.1 * [1, 2, 2, 4, 4, 6, 3, 7, 5, 5]';
    C = [4.0, 1.0, 8.0, 6.0, 3.0, 2.0, 5.0, 8.0, 6.0, 7.0;
         4.0, 1.0, 8.0, 6.0, 7.0, 9.0, 3.0, 1.0, 2.0, 3.0];
%          4.0, 1.0, 8.0, 6.0, 3.0, 2.0, 5.0, 8.0, 6.0, 7.0;
%          4.0, 1.0, 8.0, 6.0, 7.0, 9.0, 3.0, 1.0, 2.0, 3.0];

    outer = 0;
    for i = 1:m
        inner = 0;
        for j = 1:n
            inner = inner + (x(j)-C(j, i))^2;
        end
        outer = outer + 1/(inner+b(i));
    end

    y = -outer;
end
