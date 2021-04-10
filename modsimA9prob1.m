%%problem 1b


%Implicit Runge kutta 4 RK4
A = [1/4            1/4-sqrt(3)/6;
     1/4+sqrt(3)/6  1/4];

b = [1/2;
     1/2];
 
c = [1/2-sqrt(3)/6;
     1/2+sqrt(3)/6];
 
ERK4 = struct('A',A,'b',b,'c',c);

%Explicit Runge kutta 4 RK4
A4 = [0   0   0   0;
      0.5 0   0   0
      0   0.5 0   0;
      0   0   0.5 0];
B4 = [1/6; 1/3; 1/3; 1/6];
C4 = [0; 0.5; 0.5; 1];
RK4 = struct('A',A4,'b',B4,'c',C4);



dt = 0.4;
tspan = 0:dt:2;
x0 = 1;
lambda = -2;
func = @(t,x) lambda*x;
dfdx = @(t,x) lambda;
actual_solution = x0*exp(lambda*tspan);



XERK4 = ERKTemplate(RK4,func,tspan,x0);
XIRK4 = RKTemplate(ERK4, func, dfdx, tspan, x0);

