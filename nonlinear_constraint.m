function [c, ceq] = nonlinear_constraint(z)
    alpha = 0.2;
    beta = 20;
    lambda_t = 2*pi/3;
    mx = 6;
    N = 40;
    
    %allocate memory
    c = zeros(N,1);
    ceq = zeros(N,1);
    
    for i=0:N-1
        c(i+1) = alpha*exp(-beta*(z(1+i*mx)-lambda_t)^2) -z(5+i*mx);
        
    end
end