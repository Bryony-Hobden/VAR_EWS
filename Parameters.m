%% April 2026 Parameters for slow ramp experiments for the fold on the slow manifold, subcritical Hopf, and singular Hopf
%define default paramters and then nummber of variants as
% pars(1..n)

% Singular Hopf parameters
par.Name = 'SingHopf_slowramp';
par.Title= "Singular Hopf";
par.system = @ode_singhopf;
par.system_jac = @ode_singhopf_jac;
par.lambda_0 = 0.4;
%set alphax and alphay to non zero values for noisey simulations
par.alphax = 0.005;
par.alphay = 0.005;
par.epsilon = 0.01;
par.r = 0.005;
par.tspan = [0 90];
par.dt = 0.001;
par.blocksize=1000; % block size for analysis
par.seed = 'default';
par.v0= [0.4 ; (1+0.4)*(0.4)^2]; %starting on critical manifold
par.plot = 1;
par.omega = 0;
par.sub=5;
par.evplot=2; % =2 for leading real part, =1 for non-leading part

%Singular Hopf (see above)
pars(1) = par;

%Hopf
pars(2) = par;
pars(2).Name = 'Hopf_slowramp';
pars(2).Title="Subcritical Hopf";
pars(2).system = @ode_hopf;
pars(2).system_jac = @ode_hopf_jac;
pars(2).lambda_0 = 3;
pars(2).r = 0.01;
pars(2).tspan = [0 350];
pars(2).dt=0.01;
pars(2).blocksize=250;
pars(2).v0= [0; 0]; %starting at stable fixed point
pars(2).alphax = 0.05;
pars(2).alphay = 0.05;
pars(2).plot = 2;
pars(2).omega=0.3;
pars(2).sub = 10;
pars(2).epsilon = 1;


%Fold
pars(3) = par;
pars(3).Name = 'Fold_slowramp';
pars(3).Title="Fold on slow manifold";
pars(3).system = @ode_fold;
pars(3).system_jac = @ode_fold_jac;
pars(3).lambda_0 = 0.3;
pars(3).alphax = 0.01;
pars(3).alphay = 0.01;
pars(3).epsilon = 0.1;
pars(3).r = 0.001;
pars(3).dt = 0.002;
pars(3).tspan = [0 350];
pars(3).blocksize=1250; 
pars(3).v0= [0.3; 0.514]; %starting on/near critical manifold near fixed point
pars(3).plot = 3;
pars(3).sub =10;
