%% Subcritical Hopf phase portrait parameters
%define default paramters and then nummber of variants as
% pars(1..n)

% Hopf parameters
par.Name = 'Default_params';
par.system = @ode_hopf;
par.system_jac = @ode_hopf_jac;
par.lambda_0 = 0.4;
par.alphax = 0.01;
par.alphay = 0.01;
par.epsilon = 1;
par.r = 0;
par.dt = 0.01;
par.tspan = [0 20];
par.blocksize=10000; % block size for analysis
par.seed = 'default';
par.v0= [0.4 ; (1+0.4)*(0.4)^2]; %starting on critical manifold
par.omega = 1;
par.plot=1;

%% Hopf 1 (stable limit cycle, unstable node) 
pars(1) = par;
pars(1).Name = 'Hopf_1_traj';
pars(1).system = @ode_hopf;
pars(1).system_jac = @ode_hopf_jac;
pars(1).lambda_0 = -0.25;
pars(1).dt = 0.01;
pars(1).tspan = [0 200]; 
pars(1).v0= [0.4 ; 0.4]; %starting on critical manifold
ICx = [1.5 1.25 -1.5 -1 -1.5 -1.25 1.5 1 -0.1 0.3];
ICy = [1 1.5 1.25 1.5 -1 -1.5 -1.25 -1.5 0.1 0.3];


k=1;
for i = 1:length(ICx)
    k = k+1;
    pars(k) = pars(1);
    pars(k).Name = sprintf('Hopf_1_%d', i);
    pars(k).v0= [ICx(i) ; ICy(i)];
    pars(k).alphax =0;
    pars(k).alphay =0;
end

%% Hopf 2 (stable limit cycle, unstable limit cycle, stable node)

k=k+1;
pars(k) = par;
pars(k).Name = 'Hopf_2_traj';
pars(k).system = @ode_hopf;
pars(k).system_jac = @ode_hopf_jac;
pars(k).lambda_0 = 0.15;
pars(k).dt = 0.01;
pars(k).tspan = [0 200]; 
pars(k).v0= [0.4 ; 0.4]; %starting on critical manifold

ICx = [1.5 1.25 -1.5 -1 -1.5 -1.25 1.5 1 -0.1 0.3 -0.5];
ICy = [1 1.5 1.25 1.5 -1 -1.5 -1.25 -1.5 0.1 0.3 0];

for i = 1:length(ICx)
    k = k+1;
    pars(k) = pars(k-1);
    pars(k).Name = sprintf('Hopf_2_%d', i);
    pars(k).v0= [ICx(i) ; ICy(i)];
    pars(k).alphax =0;
    pars(k).alphay =0;
end

%% Hopf 3 (one stable node)

k=k+1;
pars(k) = par;
pars(k).Name = 'Hopf_3_traj';
pars(k).system = @ode_hopf;
pars(k).system_jac = @ode_hopf_jac;
pars(k).lambda_0 = 0.4;
pars(k).dt = 0.01;
pars(k).tspan = [0 200]; 
pars(k).v0= [0.4 ; 0.4]; %starting on critical manifold

ICx = [1.5 1.25 -1.5 -1 -1.5 -1.25 1.5 1 -0.1 0.3];
ICy = [1 1.5 1.25 1.5 -1 -1.5 -1.25 -1.5 0.1 0.3];

for i = 1:length(ICx)
    k = k+1;
    pars(k) = pars(k-1);
    pars(k).Name = sprintf('Hopf_3_%d', i);
    pars(k).v0= [ICx(i) ; ICy(i)];
    pars(k).alphax =0;
    pars(k).alphay =0;
end