function [S,I, R, dt, time, alldt] = Gillespie_alg(t,init,params)
% parameters
a = params(1); % mortality rate
b = params(2); % infection rate

% vectors
S = zeros(t,1);
I = zeros(t,1);
R = zeros(t,1);
time = zeros(t,1);

rate = zeros(2,1);
dt = zeros(2,1);
alldt(1) = 0;
% initial conditions
S(1) = init(1);
I(1) = init(2);
R(1) = init(3);
time(1) = 0;

% counter
i=2;
tic
% Gillespie's algorithm
while(time(i-1) <= t)
    % check if I is zero
    if(I(i-1) == 0)
        S(i) = S(i-1);
        I(i) = I(i-1);
        R(i) = R(i-1);
    else
        % contact rate
        rate(1) = a*S(i-1)*I(i-1);
        
        % recovery rate
        rate(2) = b*I(i-1);
        
        
        % times to the next event for each event (dt)
        j = 1;
        while(j <= 2)
            dt(j) = -log(rand(1))/rate(j);
         %   alldt(i+1) = [alldt,dt(j)];
            j=j+1;
        end
       
        % determine the time to the next event 
        [min_t,k] = min(dt);
        alldt(i)=min_t;
        
        % update the system states
        if(k==1)
            % infection
            S(i) = S(i-1)-1;
            I(i) = I(i-1)+1;
            R(i) = R(i-1);
        else
            % recovery
            S(i) = S(i-1);
            I(i) = I(i-1)-1;
            R(i) = R(i-1)+1;
        end
     end
    
    % increase to the next time step
    time(i) = time(i-1) + dt(k);
    i = i+1;
end
toc
return