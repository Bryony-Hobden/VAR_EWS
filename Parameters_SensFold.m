% Parameters for varaible sensitivty analysis

% Original fold parameters
par.Name = 'Fold_slowramp';
par.Title="Fold on slow manifold";
par.system = @ode_fold;
par.system_jac = @ode_fold_jac;
par.lambda_0 = 0.3;
par.alphax = 0.01;
par.alphay = 0.01;
par.epsilon = 0.1;
par.r = 0.001;
par.dt = 0.002;
par.tspan = [0 350];
par.blocksize=1250; 
par.seed = 'default';
par.v0= [0.3; 0.514]; %starting on/near critical manifold near fixed point
par.plot = 3;
par.sub =10;

pars(1) = par;
%% Noise
pars(2)=par;
pars(2).Name ='F_small_noise';
pars(2).alphax = 0.005; %half
pars(2).alphay = 0.005;

pars(3)=par;
pars(3).Name ='F_big_noise';
pars(3).alphax = 0.02; %double
pars(3).alphay = 0.02;

%% Ramping rate
pars(4)=par;
pars(4).Name ='Orig_r';
pars(4).r= 0.001; 
pars(4).tspan = [0 800];

pars(5)=par;
pars(5).Name ='F_small_r';
pars(5).r= 0.0005; %half
pars(5).tspan = [0 800];

pars(6)=par;
pars(6).Name ='F_big_r';
pars(6).r= 0.002; %double
pars(6).tspan = [0 800];

%% subsampling
pars(7)=par;
pars(7).Name ='F_small_sub';
pars(7).sub = 5;

pars(8)=par;
pars(8).Name ='F_big_sub';
pars(8).sub = 20;

%% blocksize
pars(9)=par;
pars(9).Name ='F_small_bs';
pars(9).blocksize = 500;

pars(10)=par;
pars(10).Name ='F_big_bs';
pars(10).blocksize = 2000;
