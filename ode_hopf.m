function dvdt = ode_hopf(t, v, options)

% this function computes the rhs of the subcritical Hopf system

    omega = options.omega;

    dxdt = -lambda(t, options)*v(1) - omega*v(2) + v(1)^3 + v(1)*(v(2)^2)-v(1)^5 - 2*(v(1)^3)*(v(2)^2) - (v(2)^4)*v(1);
    
    dydt = -lambda(t, options)*v(2) + omega*v(1) + (v(1)^2)*v(2) + v(2)^3 - (v(1)^4)*v(2) - 2*(v(1)^2)*(v(2)^3) -v(2)^5;
    
    dvdt = [dxdt ; dydt];

end