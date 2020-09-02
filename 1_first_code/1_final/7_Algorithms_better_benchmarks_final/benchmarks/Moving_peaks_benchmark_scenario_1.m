function y = Moving_peaks_benchmark_scenario_1(x)
    % The number of variables n should be adjusted below.
    % The default value of n =2.
    %
    n = 2;   % n=2 means that X and Y
    
    %%% first minimum:
    h = 10;   % height
    w = 0.1;   % width
    p = [60 80];   % position
    s = 0;
    for j = 1:n
        s = s + (x(j) - p(j))^2;
    end
    y = h / (1 + w*s);
    
    %%% second minimum:
    h = 8;   % height
    w = 0.01;   % width
    p = [80 30];   % position
    s = 0;
    for j = 1:n
        s = s + (x(j) - p(j))^2;
    end
    y = y + (h / (1 + w*s));
    
    %%% third minimum:
    h = 11;   % height
    w = 0.08;   % width
    p = [10 10];   % position
    s = 0;
    for j = 1:n
        s = s + (x(j) - p(j))^2;
    end
    y = y + (h / (1 + w*s));
    
    %%% forth minimum:
    h = 8;   % height
    w = 0.01;   % width
    p = [-80 -30];   % position
    s = 0;
    for j = 1:n
        s = s + (x(j) - p(j))^2;
    end
    y = y + (h / (1 + w*s));
    
    %%% fifth minimum:
    h = 8;   % height
    w = 0.01;   % width
    p = [-60 40];   % position
    s = 0;
    for j = 1:n
        s = s + (x(j) - p(j))^2;
    end
    y = y + (h / (1 + w*s));
    
    %%% sixth minimum:
    h = 5;   % height
    w = 0.1;   % width
    p = [40 -60];   % position
    s = 0;
    for j = 1:n
        s = s + (x(j) - p(j))^2;
    end
    y = y + (h / (1 + w*s));
    
    y = -y;
end