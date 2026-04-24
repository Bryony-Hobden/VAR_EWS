function [var] = heun_integrator(ode, v0, options)

% heun_integrator performs time integration of SDE via Heun integration
% SDE must be a function of y and t @(t,y) ode(t,y)
% v0 is the initial condition 2x1 vector

    % noise and timestep
    seed    = options.seed;
    alphax  = options.alphax;
    alphay  = options.alphay;
    epsilon = options.epsilon;
    tspan   = options.tspan;

    % set random seed
    rng(seed)

    dt = options.dt;

    % determine integration direction
    if tspan(end) < tspan(1)
        dt = -abs(dt);
    else
        dt = abs(dt);
    end

    t0 = tspan(1);

    % initialise vectors
    Tout = t0;
    Vout = v0;

    tp = t0;
    Vp = v0;

    tn = t0 + dt;

    % define loop condition depending on direction
    if dt > 0
        condition = @(t) t < tspan(end);
    else
        condition = @(t) t > tspan(end);
    end

    while condition(tp)

        dta = min(abs(dt), abs(tspan(end) - tp)) * sign(dt);
        tn  = tp + dta;

        % Wiener increment (always uses positive timestep magnitude)
        Wn = sqrt(abs(dta)) * randn(2,1);

        % Heun integration steps
        rhs1 = ode(tp, Vp, options);

        Vt = Vp + rhs1*dta + [(1/sqrt(epsilon))*alphax ; alphay] .* Wn;

        rhs2 = ode(tn, Vt, options);

        Vn = Vp + 0.5*(rhs1 + rhs2)*dta + [(1/sqrt(epsilon))*alphax ; alphay] .* Wn;

        Tout = [Tout , tn];
        Vout = [Vout , Vn];

        % update for next iteration
        tp = tn;
        Vp = Vn;

    end

    % create output
    var.t = Tout;
    var.v = Vout;

end
