% function function_plot
 clear;close all
global initial_flag

% Xmin=[-100,-100,-100,-100,-100,-100,0,-32,-5,-5,-0.5,-pi,-3,-100,-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,2];
% Xmax=[100,100,100,100,100,100,600,32,5,5,0.5,pi,1,100,5,5,5,5,5,5,5,5,5,5,5];

for func_num=1:25
    if func_num==1 x=-100:5:100;y=x; %[-100,100]
    elseif func_num==2 x=-100:5:100; y=x;%[-10,10]
    elseif func_num==3 x=-100:5:100; y=x;%[-100,100]
    elseif func_num==4 x=-100:5:100; y=x;%[-100,100]
    elseif func_num==5 x=-100:5:100;y=x; %[-5,5]
    elseif func_num==6 x=-100:5:100; y=x;%[-3,1]
    elseif func_num==7 x=-1000:100:1000; y=x;%[-600,600]
    elseif func_num==8 x=-32:1:32; y=x;%[-32,32]
    elseif func_num==9 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==10 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==11 x=-0.5:0.01:0.5; y=x;%[-0.5,0.5]
    elseif func_num==12 x=-100:5:100; y=x;%[-pi,pi]
    elseif func_num==13 x=-3:0.1:1; y=x;%[-3,1]
    elseif func_num==14 x=-100:5:100; y=x;%[-100,100]
    elseif func_num==15 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==16 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==17 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==18 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==19 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==20 x=-5:0.1:5; y=x;%[-5,5]        
    elseif func_num==21 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==22 x=-5:0.1:5; y=x;%[-5,5]     
    elseif func_num==23 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==24 x=-5:0.1:5; y=x;%[-5,5]   
    elseif func_num==25 x=-5:0.1:5; y=x;%[-5,5]  
    end
    
initial_flag=0;
L=length(x);
f=[];

for i=1:L
for j=1:L
f(i,j)=benchmark_func([x(i),y(j)],func_num);
end
end

fig = figure(func_num);
surfc(x,y,f);

%%% save ROC curve:
PathName = './saved_figures/';
dirname = fullfile(PathName,func_num,'.png');
imglist = dir(dirname);
str = sprintf('%s%d.png', PathName, func_num);
saveas(fig, str);

end

