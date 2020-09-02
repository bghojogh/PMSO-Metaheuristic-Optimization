function [bounds_of_search, initialization_range] = get_bounds_of_benchmark(func_num)

if func_num==1 
    bounds_of_search = [-100,100];
elseif func_num==2
    bounds_of_search = [-100,100];
elseif func_num==3
    bounds_of_search = [-100,100];
elseif func_num==4
    bounds_of_search = [-100,100];
elseif func_num==5
    bounds_of_search = [-100,100];
elseif func_num==6
    bounds_of_search = [-100,100];
elseif func_num==7
    bounds_of_search = [-inf,inf];
elseif func_num==8
    bounds_of_search = [-32,32];
elseif func_num==9
    bounds_of_search = [-5,5];
elseif func_num==10
    bounds_of_search = [-5,5];
elseif func_num==11
    bounds_of_search = [-0.5,0.5];
elseif func_num==12
    bounds_of_search = [-100,100];
elseif func_num==13
    bounds_of_search = [-3,1];
elseif func_num==14
    bounds_of_search = [-100,100];
elseif func_num==15
    bounds_of_search = [-5,5];
elseif func_num==16
    bounds_of_search = [-5,5];
elseif func_num==17
    bounds_of_search = [-5,5];
elseif func_num==18
    bounds_of_search = [-5,5];
elseif func_num==19
    bounds_of_search = [-5,5];
elseif func_num==20    
    bounds_of_search = [-5,5];
elseif func_num==21
    bounds_of_search = [-5,5];
elseif func_num==22     
    bounds_of_search = [-5,5];
elseif func_num==23
    bounds_of_search = [-5,5];
elseif func_num==24 
    bounds_of_search = [-5,5];
elseif func_num==25
    bounds_of_search = [-inf,inf];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if func_num ~= 7 && func_num ~= 25
    initialization_range = bounds_of_search;
elseif func_num == 7
    initialization_range = [0,600];
elseif func_num == 25
    initialization_range = [-2,5];
end

end