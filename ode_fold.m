function dvdt = ode_fold(t, v, options)
% this function calculates the rhs of the fold on the slow manifold system
    epsilon = options.epsilon;
    
    dxdt = (1/epsilon)*(-v(1) +  v(2).^2*(1 + v(2)));
    
    dydt = (lambda(t, options) - v(1));
    
    dvdt = [dxdt ; dydt];

end