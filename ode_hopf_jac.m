function jac = ode_hopf_jac(t, v, options)

%  this function computes the analytical jacobian of the subcritical Hopf
%  system

    omega = options.omega;

    dxdt = -lambda(t, options)*v(1) - omega*v(2) + v(1)^3 + v(1)*v(2)^2 -v(1)^5 -2*v(1)^3*v(2)^2 - v(2)^4*v(1);
    
    dydt = -lambda(t, options)*v(2) + omega*v(1) + v(1)^2*v(2) +v(2)^3 - v(1)^4*v(2) - 2*v(1)^2*v(2)^3 -v(2)^5;
    
    dvdt = [dxdt ; dydt];

    Jxx =-lambda(t, options) +3*v(1)^2 + v(2)^2 - 5*v(1)^4 -6*v(1)^2*v(2)^2 - v(2)^4;

    Jxy = -omega + 2*v(1)*v(2) - 4*v(1)^3*v(2) -4*v(2)^3*v(1);

    Jyx = omega +2*v(1)*v(2) -4*v(1)^3*v(2) -4*v(1)*v(2)^3;

    Jyy = -lambda(t, options) +v(1)^2 +3*v(2)^2 - v(1)^4 - 6*v(1)^2*v(2)^2 -5*v(2)^4;

    jac = [Jxx, Jxy  ; Jyx , Jyy];

end