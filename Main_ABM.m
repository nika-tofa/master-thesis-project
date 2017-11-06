clc
clear all;
close all;

%% ABM for case of British Boardig School
% the idea of the code is proposed by prof. Heikki Haario

% parameters
alpha = 0.002;  % contact rate
beta  = 0.4;    % recovery rate
Total  = 763;  % population size

finaltime = 14;  % time interval [0,finaltime]
nsimustep = 300;
time      = linspace(0,finaltime,nsimustep);
delta     = time(2)-time(1);

tic
for K=1:1
ind_col = (K-1)*3+1:K*3;
nS = Total-1; 
nI = 1;
nR = 0;
S0 = [nS nI nR]';
NN(1,ind_col) = S0; 
A(1,K) = nS; B(1,K) = nI;
    K;
    for k=2:nsimustep
     r = rand(nS,1);  % randomly select the fortunes
     nr_S = sum(r < alpha*delta*nI);    % count the reacting ones
     r2 = rand(nI,1);
     nr_I = sum(r2 < beta*delta);       
     nS = nS-nr_S;   % and remove from population
     nI = nI-nr_I+nr_S;  
     nR = nR+nr_I;
     NN(k,ind_col) = [nS nI nR];
    end
end
toc

tic
[t,y]=ode45(@bbs_ode,time,S0,[],[alpha,beta]); 
toc

figure(1)
plot(time,NN,'g-'); 
hold on; 
plot(t,y,'-','LineWidth',1.5);
hold off;
xlabel('Time in days');
ylabel('Number of individuals');
title('Comparison with the numerical solution');
% figure(2)
% plot(time,NN(:,1:3:30),'g-'); 
% hold on; 
% plot(t,y(:,1),'k.','MarkerSize',6);
% hold off;
% xlabel('Time in days');
% ylabel('Number of susceptible individuals');
% 
% figure(3)
% plot(time,NN(:,2:3:30),'g-'); 
% hold on; 
% plot(t,y(:,2),'k.','MarkerSize',6);
% hold off;
% xlabel('Time in days');
% ylabel('Number of infected individuals');
% 
% figure(4)
% plot(time,NN(:,3:3:30),'g-'); 
% hold on; 
% plot(t,y(:,3),'k.','MarkerSize',6);
% hold off;
% xlabel('Time in days');
% ylabel('Number of recovered individuals');
% %legend('ABM','ODE')
