%% Parameters for varaible sensitivty analysis

% Original Singular Hopf parameters
par.Name = 'SingHopf_slowramp';
par.Title= "Singular Hopf";
par.system = @ode_singhopf;
par.system_jac = @ode_singhopf_jac;
par.lambda_0 = 0.4;
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
%% Noise
pars(2)=par;
pars(2).Name ='SH_small_noise';
pars(2).alphax = 0.0025; %not half
pars(2).alphay = 0.0025;

pars(3)=par;
pars(3).Name ='SH_big_noise';
pars(3).alphax = 0.01; %double
pars(3).alphay = 0.01;

%% Ramping rate
pars(4)=par;
pars(4).Name ='SHOrig_r';
pars(4).r= 0.005; %half


pars(5)=par;
pars(5).Name ='SH_small_r';
pars(5).r= 0.0025; %half
pars(5).tspan = [0 200];

pars(6)=par;
pars(6).Name ='SH_big_r';
pars(6).r= 0.01; %double

%% subsampling
pars(7)=par;
pars(7).Name ='SH_small_sub';
pars(7).sub = 2;

pars(8)=par;
pars(8).Name ='SH_big_sub';
pars(8).sub = 10;

%% blocksize
pars(9)=par;
pars(9).Name ='SH_small_bs';
pars(9).blocksize = 500;

pars(10)=par;
pars(10).Name ='SH_big_bs';
pars(10).blocksize = 2000;