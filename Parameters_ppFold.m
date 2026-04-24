%% Fold on the slow manifold phase portrait parameters
%define default paramters and then nummber of variants as
% pars(1..n)

% parameters required to produce fold on the slow manifold phase portraits

% Fold parameters
par.Name = 'Default_params';
par.system = @ode_fold;
par.system_jac = @ode_fold_jac;
par.lambda_0 = 0.4;
par.alphax = 0.01;
par.alphay = 0.01;
par.epsilon = 0.1;
par.r = 0;
par.dt = 0.0001;
par.tspan = [0 20];
par.blocksize=10000; % block size for analysis
par.seed = 'default';
par.v0= [0.4 ; (1+0.4)*(0.4)^2]; %starting on critical manifold
par.plot=1;
par.omega=0;


%% Fold 1
pars(1) = par;
pars(1).Name = 'Fold_1_traj';
pars(1).system = @ode_fold;
pars(1).system_jac = @ode_fold_jac;
pars(1).lambda_0 = 0.1;
pars(1).dt = 0.001;
pars(1).tspan = [0 20]; 
pars(1).v0= [0.4 ; 0.4]; %starting on critical manifold

ICx = [0.2 0.2 -0.2 0.2 -0.2 -0.2 -0.2];
ICy = [0.3 -0.45 -0.35 -1.1 -0.1 -0.6 -1.1];  

k=1;
for i = 1:length(ICx)
    k = k+1;
    pars(k) = pars(1);
    pars(k).Name = sprintf('Fold_1_%d', i);
    pars(k).v0= [ICx(i) ; ICy(i)];
    pars(k).alphax =0;
    pars(k).alphay =0;
end
%% Fold 2

k=k+1;
pars(k) = par;
pars(k).Name = 'Fold_2_traj';
pars(k).system = @ode_fold;
pars(k).system_jac = @ode_fold_jac;
pars(k).lambda_0 = 0;
pars(k).dt = 0.001;
pars(k).tspan = [0 1000]; 
pars(k).v0= [0.4 ; 0.4]; %starting on critical manifold

IICx = [0.2 0.2 -0.2 0.2 -0.2 -0.2 -0.2];
ICy = [0.3 -0.45 -0.35 -1.1 -0.1 -0.6 -1.1]; 

for i = 1:length(ICx)
    k = k+1;
    pars(k) = par;
    pars(k).Name = sprintf('Fold_2_%d', i);
    pars(k).v0= [ICx(i) ; ICy(i)];
    pars(k).alphax =0;
    pars(k).alphay =0;
    pars(k).lambda_0 = 0;
end
%% Fold 3

k=k+1;
pars(k) = par;
pars(k).Name = 'Fold_3_traj';
pars(k).system = @ode_fold;
pars(k).system_jac = @ode_fold_jac;
pars(k).lambda_0 = -0.1;
pars(k).dt = 0.0001;
pars(k).tspan = [0 20]; 
pars(k).v0= [0.4 ; 0.4]; %starting on critical manifold

ICx = [0.2 0.2 -0.2 0.2 -0.2 -0.2 -0.2];
ICy = [0.3 -0.45 -0.35 -1.1 -0.1 -0.6 -1.1]; 

for i = 1:length(ICx)
    k = k+1;
    pars(k) = par;
    pars(k).Name = sprintf('Fold_3_%d', i);
    pars(k).v0= [ICx(i) ; ICy(i)];
    pars(k).alphax =0;
    pars(k).alphay =0;
    pars(k).lambda_0 = -0.1;
end