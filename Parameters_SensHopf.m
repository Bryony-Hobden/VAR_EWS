%% Parameters for variable sensitivty analysis

% Original Hopf parameters
par.Name = 'Hopf_slowramp';
par.Title="Subcritical Hopf";
par.system = @ode_hopf;
par.system_jac = @ode_hopf_jac;
par.lambda_0 = 3;
par.r = 0.01;
par.tspan = [0 350];
par.dt=0.01;
par.blocksize=250;
par.v0= [0; 0]; %starting at stable fixed point
par.alphax = 0.05;
par.alphay = 0.05;
par.plot = 2;
par.omega=0.3;
par.sub = 10;
par.epsilon = 1;
par.seed = 'default';

pars(1)=par;
%% Noise
pars(2)=par;
pars(2).Name ='H_small_noise';
pars(2).alphax = 0.025; %half
pars(2).alphay = 0.025;

pars(3)=par;
pars(3).Name ='H_big_noise';
pars(3).alphax = 0.1; %double
pars(3).alphay = 0.1;

%% Ramping rate
pars(4)=par;
pars(4).Name ='HOrig_r';
pars(4).r= 0.01; 

pars(5)=par;
pars(5).Name ='H_small_r';
pars(5).r= 0.005; %half
pars(5).tspan = [0 800];

pars(6)=par;
pars(6).Name ='H_big_r';
pars(6).r= 0.02; %double
pars(6).tspan = [0 800];

%% subsampling
pars(7)=par;
pars(7).Name ='H_small_sub';
pars(7).sub = 5;

pars(8)=par;
pars(8).Name ='H_big_sub';
pars(8).sub = 20;

%% blocksize
pars(9)=par;
pars(9).Name ='H_small_bs';
pars(9).blocksize = 125;

pars(10)=par;
pars(10).Name ='H_big_bs';
pars(10).blocksize = 500;
