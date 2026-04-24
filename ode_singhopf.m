function dvdt = ode_singhopf(t, v, options)

% this function computes the rhs of the singular hopf system 

    epsilon = options.epsilon;
    
    dxdt = (1/epsilon)*(v(2) -  v(1).^2*(1 + v(1)));
    
    dydt = lambda(t, options) - v(1);
    
    dvdt = [dxdt ; dydt];

end