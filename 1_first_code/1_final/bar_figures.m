clc
clear all
close all

%% F1:
%%%%%%%%%%%%%% 5 particles:
PMSO(1) = 1.4478;
PSO(1) = 0.2758;
GA(1) = 0.4236;
Sum = PMSO(1) + PSO(1) + GA(1);
PMSO(1) = (PMSO(1) / Sum) * 100;
PSO(1) = (PSO(1) / Sum) * 100;
GA(1) = (GA(1) / Sum) * 100;

%%%%%%%%%%%%%% 10 particles:
PMSO(2) = 1.1121;
PSO(2) = 0.2850;
GA(2) = 0.0960;
Sum = PMSO(2) + PSO(2) + GA(2);
PMSO(2) = (PMSO(2) / Sum) * 100;
PSO(2) = (PSO(2) / Sum) * 100;
GA(2) = (GA(2) / Sum) * 100;

%%%%%%%%%%%%%% 15 particles:
PMSO(3) = 0.6859;
PSO(3) = 0.2834;
GA(3) = 0.0657;
Sum = PMSO(3) + PSO(3) + GA(3);
PMSO(3) = (PMSO(3) / Sum) * 100;
PSO(3) = (PSO(3) / Sum) * 100;
GA(3) = (GA(3) / Sum) * 100;

%%%%%%%%%%%%%% averaging:
PMSO_average = mean(PMSO);
PSO_average = mean(PSO);
GA_average = mean(GA);

%%%%%%%%%%%%%% creating F1:
F(1,:) = [PMSO_average, PSO_average, GA_average];

%% F2:
%%%%%%%%%%%%%% 5 particles:
PMSO(1) = 8.2902;
PSO(1) = 3.7709;
GA(1) = 9.8706;
Sum = PMSO(1) + PSO(1) + GA(1);
PMSO(1) = (PMSO(1) / Sum) * 100;
PSO(1) = (PSO(1) / Sum) * 100;
GA(1) = (GA(1) / Sum) * 100;

%%%%%%%%%%%%%% 10 particles:
PMSO(2) = 7.4949;
PSO(2) = 3.2434;
GA(2) = 6.3269;
Sum = PMSO(2) + PSO(2) + GA(2);
PMSO(2) = (PMSO(2) / Sum) * 100;
PSO(2) = (PSO(2) / Sum) * 100;
GA(2) = (GA(2) / Sum) * 100;

%%%%%%%%%%%%%% 15 particles:
PMSO(3) = 7.3416;
PSO(3) = 3.3406;
GA(3) = 5.1359;
Sum = PMSO(3) + PSO(3) + GA(3);
PMSO(3) = (PMSO(3) / Sum) * 100;
PSO(3) = (PSO(3) / Sum) * 100;
GA(3) = (GA(3) / Sum) * 100;

%%%%%%%%%%%%%% averaging:
PMSO_average = mean(PMSO);
PSO_average = mean(PSO);
GA_average = mean(GA);

%%%%%%%%%%%%%% creating F2:
F(2,:) = [PMSO_average, PSO_average, GA_average];

%% F3:
%%%%%%%%%%%%%% 5 particles:
PMSO(1) = 1.9898;
PSO(1) = 0.3506;
GA(1) = 1.0906;
Sum = PMSO(1) + PSO(1) + GA(1);
PMSO(1) = (PMSO(1) / Sum) * 100;
PSO(1) = (PSO(1) / Sum) * 100;
GA(1) = (GA(1) / Sum) * 100;

%%%%%%%%%%%%%% 10 particles:
PMSO(2) = 1.4596;
PSO(2) = 0.4236;
GA(2) = 0.2340;
Sum = PMSO(2) + PSO(2) + GA(2);
PMSO(2) = (PMSO(2) / Sum) * 100;
PSO(2) = (PSO(2) / Sum) * 100;
GA(2) = (GA(2) / Sum) * 100;

%%%%%%%%%%%%%% 15 particles:
PMSO(3) = 0.9215;
PSO(3) = 0.3476;
GA(3) = 0.0874;
Sum = PMSO(3) + PSO(3) + GA(3);
PMSO(3) = (PMSO(3) / Sum) * 100;
PSO(3) = (PSO(3) / Sum) * 100;
GA(3) = (GA(3) / Sum) * 100;

%%%%%%%%%%%%%% averaging:
PMSO_average = mean(PMSO);
PSO_average = mean(PSO);
GA_average = mean(GA);

%%%%%%%%%%%%%% creating F3:
F(3,:) = [PMSO_average, PSO_average, GA_average];

%% F4:
%%%%%%%%%%%%%% 5 particles:
PMSO(1) = 9.9468;
PSO(1) = 724.0000;
GA(1) = 376.9373;
Sum = PMSO(1) + PSO(1) + GA(1);
PMSO(1) = (PMSO(1) / Sum) * 100;
PSO(1) = (PSO(1) / Sum) * 100;
GA(1) = (GA(1) / Sum) * 100;

%%%%%%%%%%%%%% 10 particles:
PMSO(2) = 13.5285;
PSO(2) = 543.2500;
GA(2) = 189.5539;
Sum = PMSO(2) + PSO(2) + GA(2);
PMSO(2) = (PMSO(2) / Sum) * 100;
PSO(2) = (PSO(2) / Sum) * 100;
GA(2) = (GA(2) / Sum) * 100;

%%%%%%%%%%%%%% 15 particles:
PMSO(3) = 6.3068;
PSO(3) = 0.2500;
GA(3) = 19.9794;
Sum = PMSO(3) + PSO(3) + GA(3);
PMSO(3) = (PMSO(3) / Sum) * 100;
PSO(3) = (PSO(3) / Sum) * 100;
GA(3) = (GA(3) / Sum) * 100;

%%%%%%%%%%%%%% averaging:
PMSO_average = mean(PMSO);
PSO_average = mean(PSO);
GA_average = mean(GA);

%%%%%%%%%%%%%% creating F4:
F(4,:) = [PMSO_average, PSO_average, GA_average];

%% F5:
%%%%%%%%%%%%%% 5 particles:
PMSO(1) = 38.4721;
PSO(1) = 32.5601;
GA(1) = 59.6147;
Sum = PMSO(1) + PSO(1) + GA(1);
PMSO(1) = (PMSO(1) / Sum) * 100;
PSO(1) = (PSO(1) / Sum) * 100;
GA(1) = (GA(1) / Sum) * 100;

%%%%%%%%%%%%%% 10 particles:
PMSO(2) = 10.9815;
PSO(2) = 0.2722;
GA(2) = 60.4727;
Sum = PMSO(2) + PSO(2) + GA(2);
PMSO(2) = (PMSO(2) / Sum) * 100;
PSO(2) = (PSO(2) / Sum) * 100;
GA(2) = (GA(2) / Sum) * 100;

%%%%%%%%%%%%%% 15 particles:
PMSO(3) = 7.4049;
PSO(3) = 0.2604;
GA(3) = 77.7865;
Sum = PMSO(3) + PSO(3) + GA(3);
PMSO(3) = (PMSO(3) / Sum) * 100;
PSO(3) = (PSO(3) / Sum) * 100;
GA(3) = (GA(3) / Sum) * 100;

%%%%%%%%%%%%%% averaging:
PMSO_average = mean(PMSO);
PSO_average = mean(PSO);
GA_average = mean(GA);

%%%%%%%%%%%%%% creating F5:
F(5,:) = [PMSO_average, PSO_average, GA_average];

%% bar:
bar(F, 'grouped');
ylim([0 100]);
legend('PMSO', 'PSO', 'GA');
xlabel('Benchmarks');
ylabel('Average percent error');
set(gca, 'XTickLabel',{'F1','F2','F3','F4','F5'});
