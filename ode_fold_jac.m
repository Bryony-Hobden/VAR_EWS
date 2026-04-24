function jac = ode_fold_jac(t, v, options)
% this function outputs the analytical Jacobian of the fold on the slow
% manifold system

    epsilon = options.epsilon;
    
    dxdt = (1/epsilon)*(v(1) -  v(2).^2*(1 + v(2)));
   
    dydt = (lambda(t, options) - v(1));
    
    dvdt = [dxdt ; dydt];

    jac = [-1/epsilon, (2*v(2) + 3*v(2)^2)/epsilon , ; -1, 0];

end