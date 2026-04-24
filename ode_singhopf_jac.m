function jac = ode_singhopf_jac(t, v, options)

% this function computes the analytical jacobian of the singular Hopf
% system 

    epsilon = options.epsilon;
    
    dxdt = (1/epsilon)*(v(2) -  v(1).^2*(1 + v(1)));
    
    dydt = lambda(t, options) - v(1);
    
    dvdt = [dxdt ; dydt];

    jac = [(-2*v(1) -3*v(1)^2)/epsilon , 1/epsilon ; -1, 0];

end