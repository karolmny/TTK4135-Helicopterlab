%Elevation feedback
%% Initialization and model definition
close all;
clear all;
clc;
init; 

% Discrete time system model. x = [lambda r p p_dot]'
A_c = [0 1       0        0         0         0;
       0 0       -K_2      0         0         0;
       0 0       0        1         0         0;
       0 0       -K_1*K_pp -K_1*K_pd 0         0;
       0 0       0        0         0         1;
       0 0       0        0         -K_3*K_ep -K_3*K_ed];

B_c = [0        0;
       0        0;
       0        0; 
       K_1*K_pp 0;
       0        0;
       0        K_3*K_ep];
  
 % Number of states and inputs
mx = size(A_c,2); % Number of states (number of columns in A)
mu = size(B_c,2); % Number of inputs(number of columns in B)

delta_t = 0.25;
A_d = eye(mx) + delta_t*A_c;
B_d = B_c*delta_t;


%Tror alt over er korrekt 
%Alt under - usikker
% Initial values
x1_0 = pi;                              % Lambda
x2_0 = 0;                               % r
x3_0 = 0;                               % p
x4_0 = 0;                               % p_dot
x5_0 = 0;                               % e 
x6_0 = 0;                               % e_dot 
x0 = [x1_0 x2_0 x3_0 x4_0 x5_0 x6_0]';  % Initial values

% Time horizon and initialization
N  = 40;                                % Time horizon for states
M  = N;                                 % Time horizon for inputs
z  = zeros(N*mx+M*mu,1);                % Initialize z for the whole horizon
z0 = z;                                 % Initial value for optimization
z0(1) = pi;


%% LQController

LQ_Q = diag([12  3  2  5 10  1]);

LQ_R = diag([0.1 0.1]);

[K, S, e] = dlqr(A_d, B_d, LQ_Q, LQ_R);


%% Construction fmincon

%Values of fmincon
alpha = 0.2;
beta = 20;
lambda_t = 2*pi/3;

%Disse overkjører kanskje q1 og q2 fra LQcontroll
q1 = 0.1;  %oppgaven sier vi starter med 1 1 og endrer disse 
q2 = 0.1; 

% Generate the matrix Q and the vector c (objecitve function weights in the QP problem)
P1 = diag([q1 q2]);                     % Weight on input
Q1 = diag([2 0 0 0 0 0]);                         
G = 2*gen_q(Q1,P1,N,M);                   % gnerate Q, hint: gen_q
c = zeros(N*mx+M*mu,1);     

%% Generate system matrixes for linear model
Aeq = gen_aeq(A_d,B_d,N,mx,mu);             % Generate A, hint: gen_aeq
beq = zeros(size(Aeq,1),1);               % Generate b
beq(1:mx) =A_d*x0;
% Bounds
pk = 30*pi/180;
ul 	    = [-pk; -inf];                 % Lower bound on control
uu 	    = [pk; inf];                  % Upper bound on control

xl(1:mx,1) = -Inf*ones(mx,1);              % Lower bound on states (no bound)
xu(1:mx,1) = Inf*ones(mx,1);               % Upper bound on states (no bound)
xl(3)   = ul(1);                           % Lower bound on state x3 dotp
xu(3)   = uu(1);                           % Upper bound on state x3 
%xl(2)   = 2*ul(1);                           % Lower bound on state x2 r
%xu(2)   = 2*uu(1);                           % Upper bound on state x2 
%xl(6)   = ul(1);                           % Lower bound on state x6 dote
%xu(6)   = uu(1);                           % Upper bound on state x6

% Generate constraints on measurements and inputs
[vlb,vub]       = gen_constraints(N,M,xl,xu,ul,uu); % hint: gen_constraints
vlb(N*mx+M*mu)  = 0;                                % We want the last input to be zero
vub(N*mx+M*mu)  = 0;                                % We want the last input to be zero
 
%nonlinear constraint
fun = @(z) 1/2*z'*G*z;
opt = optimoptions('fmincon', 'Algorithm', 'sqp');
tic;
z = fmincon(fun,z0,[],[],Aeq,beq,vlb,vub,@nonlinear_constraint, opt);
toc;

%% Extract control inputs and states
u1 = [z(N*mx+1:mu:N*mx+M*mu);z(N*mx+M*mu-1)]; % Control input from solution
u2 = [z(N*mx+2:mu:N*mx+M*mu);z(N*mx+M*mu)]; %spør studass om dette
x1 = [x0(1);z(1:mx:N*mx)];              % State x1 from solution
x2 = [x0(2);z(2:mx:N*mx)];              % State x2 from solution
x3 = [x0(3);z(3:mx:N*mx)];              % State x3 from solution
x4 = [x0(4);z(4:mx:N*mx)];              % State x4 from solution
x5 = [x0(5);z(5:mx:N*mx)];
x6 = [x0(6);z(6:mx:N*mx)];

num_variables = 5/delta_t;
zero_padding = zeros(num_variables,1);
unit_padding  = ones(num_variables,1);

u1   = [zero_padding; u1; zero_padding];
u2   = [zero_padding; u2; zero_padding];
x1  = [pi*unit_padding; x1; zero_padding];
x2  = [zero_padding; x2; zero_padding];
x3  = [zero_padding; x3; zero_padding];
x4  = [zero_padding; x4; zero_padding];
x5  = [zero_padding; x5; zero_padding];
x6  = [zero_padding; x6; zero_padding];

%% Plotting
t = 0:delta_t:delta_t*(length(u1)-1);

u = [u1 u2]; 
u2model = [t', u];

%Sending data
x_opt = [x1 x2 x3 x4 x5 x6];
x2model = [t', x_opt];


