function dX = bbs_ode(t,X,b)
%
%  This m-file evaluates the right-hand side
%  of the predator-prey ODE system
%
%  dX1/dt = -b(1)*X1*X2
%  dX2/dt =  b(1)*X1*X2 - b(2)*X2

dX   =[-b(1)*X(1)*X(2);
        b(1)*X(1)*X(2)-b(2)*X(2);
        b(2)*X(2)];
