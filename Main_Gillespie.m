clc
clear all
close all

%% SIR models
a = 0.002; % contact rate
b = 0.4;   % infection rate
t = 14;    % time span

% initial values
S0 = 762;
I0 = 1;
R0 = 0;


[S, I, R, dt, time, alldt] = Gillespie_alg(t, [S0 I0 R0], [a b]);

tic
[tm,y] = ode45(@bbs_ode,[0 14],[S0 I0 R0],[],[a,b]);
toc

figure(1)
plot(time,[S I R],'g-')
hold on
plot(tm,y,'.','MarkerSize',7);%'b-','LineWidth',2);
legend('Gillespie_S', 'Gillespie_I','Gillespie_R', 'ODE_S', 'ODE_I','ODE_R');
title('Comparison with deterministic model');
xlabel('Time in days');
ylabel('Number of individuals');

figure(2)
plot(time,alldt')
title('Distribution of \Delta t values');
xlabel('Time in days');
ylabel('\Delta t');

% legend('Gillespie_S', 'ODE_S');
% title('Comparison with numerical solution of the deterministic model')
% xlabel('Time in days');
% ylabel('Number of susceptible individuals')

% 
% figure(2)
% plot(time,S,'g-','LineWidth',1.5)
% hold on
% plot(tm,y(:,1),'k.','MarkerSize',8);
% legend('Gillespie_S', 'ODE_S');
% title('Comparison with numerical solution of the deterministic model')
% xlabel('Time in days');
% ylabel('Number of susceptible individuals')
% 
% figure(3)
% plot(time,I,'g-','LineWidth',1.5)
% hold on
% plot(tm,y(:,2),'k.','MarkerSize',8);
% legend('Gillespie_I','ODE_I');
% title('Comparison with numerical solution of the deterministic model')
% xlabel('Time in days');
% ylabel('Number of infected individuals')
% 
% figure(4)
% plot(time,R,'g-','LineWidth',1.5)
% hold on
% plot(tm,y(:,3),'k.','MarkerSize',8);
% legend('Gillespie_R','ODE_R');
% title('Comparison with numerical solution of the deterministic model')
% xlabel('Time in days');
% ylabel('Number of recovered individuals')
