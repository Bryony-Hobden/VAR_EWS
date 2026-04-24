%% Singular Hopf phase portrait parameters

% Default
par.Name = 'Default_params';
par.system = @ode_singhopf;
par.system_jac = @ode_singhopf_jac;
par.lambda_0 = 0.4;
par.alphax = 0.01;
par.alphay = 0.01;
par.epsilon = 0.01;
par.r = 0;
par.dt = 0.0001;
par.tspan = [0 10];
par.blocksize=10000; % block size for analysis
par.seed = 'default';
par.v0= [0.4 ; (1+0.4)*(0.4)^2]; %starting on critical manifold
par.plot = 1;
par.omega=0;

%% stable node
pars(1) = par;
pars(1).Name = 'SingHopf_1_traj';
pars(1).lambda_0 = 0.2;
pars(1).r = 0;
pars(1).tspan = [0 2];
pars(1).epsilon = 0.01;
pars(1).v0= [0.61 ; 0.15];

ICx = [0.6 0.6 0.6 -1.2 -1.2 0.17 0.23 -0.6 0 -0.25 0.6];
ICy = [0.18 0 -0.02 0.1 0.2 0.058 0.038 0.05 0.2 0.1 -0.08];

ICxb = [-0.6 0 -0.25];
ICyb = [0.05 0.2 0.1];

k=1;
for i = 1:length(ICx)
    k = k+1;
    pars(k) = par;
    pars(k).Name = sprintf('SingHopf_1_%d', i);
    pars(k).lambda_0 = 0.2;
    pars(k).r = 0;
    pars(k).tspan = [0 2];
    pars(k).epsilon = 0.01;
    pars(k).v0= [ICx(i) ; ICy(i)];
    pars(k).alphax =0;
    pars(k).alphay =0;
end

%integrating backwards in time for some realisations
for i = 1:length(ICxb)
    k = k+1;
    pars(k) = par;
    pars(k).Name = sprintf('SingHopf_b1_%d', i);
    pars(k).lambda_0 = 0.2;
    pars(k).r = 0;
    pars(k).tspan = [2 0];
    pars(k).epsilon = 0.01;
    pars(k).v0= [ICxb(i) ; ICyb(i)];
    pars(k).alphax =0;
    pars(k).alphay =0;
end

%% stable spiral
k=k+1;
pars(k) = par;
pars(k).Name = 'SingHopf_2_traj';
pars(k).lambda_0 = 0.05;
pars(k).r = 0;
pars(k).tspan = [0 1];
pars(k).epsilon = 0.01;
pars(k).v0= [0.055 ; 3e-3];
pars(k).alphax =0.001;
pars(k).alphay =0.001;

ICx = [0.6 0.6 0.6 -1.2 -0.6 -0.25 -1.2 0.035 0];
ICy = [0.18 0.1 -0.08 0.1 0.05 0.1 0.2 2.625e-3 0.2];

ICxb = [-0.6 0 -0.25];
ICyb = [0.05 0.2 0.1];

for i = 1:length(ICx)
    k = k+1;
    pars(k) = par;
    pars(k).Name = sprintf('SingHopf_2_%d', i);
    pars(k).lambda_0 = 0.05;
    pars(k).r = 0;
    pars(k).tspan = [0 10];
    pars(k).epsilon = 0.01;
    pars(k).v0= [ICx(i) ; ICy(i)];
    pars(k).alphax =0;
    pars(k).alphay =0;
end

for i = 1:length(ICxb)
    k = k+1;
    pars(k) = par;
    pars(k).Name = sprintf('SingHopf_b2_%d', i);
    pars(k).lambda_0 = 0.05;
    pars(k).r = 0;
    pars(k).tspan = [2 0];
    pars(k).epsilon = 0.01;
    pars(k).v0= [ICxb(i) ; ICyb(i)];
    pars(k).alphax =0;
    pars(k).alphay =0;
end
%% centres
k=k+1;
pars(k) = par;
pars(k).Name = 'SingHopf_3_traj';
pars(k).lambda_0 = 0;
pars(k).r = 0;
pars(k).tspan = [0 1];
pars(k).epsilon = 0.01;
pars(k).v0= [0.055 ; 3e-3];

ICx = [0.6 0.6 0.6 -1.2 -0.6 -0.25 -1.2 0];
ICy = [0.18 0.1 -0.08 0.1 0.05 0.1 0.2 0.2];

ICxb = [-0.6 0 -0.25];
ICyb = [0.05 0.2 0.1];

for i = 1:length(ICx)
    k = k+1;
    pars(k) = par;
    pars(k).Name = sprintf('SingHopf_3_%d', i);
    pars(k).lambda_0 = 0;
    pars(k).r = 0;
    pars(k).tspan = [0 10];
    pars(k).epsilon = 0.01;
    pars(k).v0= [ICx(i) ; ICy(i)];
    pars(k).alphax =0;
    pars(k).alphay =0;    
end

for i = 1:length(ICxb)
    k = k+1;
    pars(k) = par;
    pars(k).Name = sprintf('SingHopf_b3_%d', i);
    pars(k).lambda_0 = 0;
    pars(k).r = 0;
    pars(k).tspan = [2 0];
    pars(k).epsilon = 0.01;
    pars(k).v0= [ICxb(i) ; ICyb(i)];
    pars(k).alphax =0;
    pars(k).alphay =0;
end
%% unstable spiral
k=k+1;
pars(k) = par;
pars(k).Name = 'SingHopf_4_traj';
pars(k).lambda_0 = -0.05;
pars(k).r = 0;
pars(k).tspan = [0 1];
pars(k).epsilon = 0.01;
pars(k).v0= [-0.05 ; 0.0025];

% Initial conditions
ICx = [0.6 0.6 0.6 -1.2 -0.6 -0.25 -1.2 -0.05-0.00001 -0.05+0.00001 0];
ICy = [0.18 0.1 -0.08 0.1 0.05 0.1 0.2 0.0024+0.00001 0.0024-0.00001 0.2];

ICxb = [-0.6 0 -0.25];
ICyb = [0.05 0.2 0.1];

for i = 1:length(ICx)
    k = k+1;
    pars(k) = par;
    pars(k).Name = sprintf('SingHopf_4_%d', i);
    pars(k).lambda_0 = -0.05;
    pars(k).r = 0;
    pars(k).tspan = [0 100];
    pars(k).epsilon = 0.01;
    pars(k).v0= [ICx(i) ; ICy(i)];
    pars(k).alphax =0;
    pars(k).alphay =0;  
end

for i = 1:length(ICxb)
    k = k+1;
    pars(k) = par;
    pars(k).Name = sprintf('SingHopf_b4_%d', i);
    pars(k).lambda_0 = -0.05;
    pars(k).r = 0;
    pars(k).tspan = [2 0];
    pars(k).epsilon = 0.01;
    pars(k).v0= [ICxb(i) ; ICyb(i)];
    pars(k).alphax =0;
    pars(k).alphay =0;
end
%% unstable node
k=k+1;
pars(k) = par;
pars(k).Name = 'SingHopf_5_traj';
pars(k).lambda_0 = -0.2;
pars(k).r = 0;
pars(k).tspan = [0 1];
pars(k).epsilon = 0.01;
pars(k).v0= [-0.05 ; 0.0025];

ICx = [0.6 0.6 0.6 -1.2 -0.6 -0.25 -1.2 -0.2-0.001 -0.2+0.001 0];
ICy = [0.18 0.1 -0.08 0.1 0.05 0.1 0.2 0.032+0.001 0.032-0.001 0.2];

ICxb = [-0.6 0 -0.25];
ICyb = [0.05 0.2 0.1];

for i = 1:length(ICx)
    k = k+1;
    pars(k) = par;
    pars(k).Name = sprintf('SingHopf_5_%d', i);
    pars(k).lambda_0 = -0.2;
    pars(k).r = 0;
    pars(k).tspan = [0 100];
    pars(k).epsilon = 0.01;
    pars(k).v0= [ICx(i) ; ICy(i)];
    pars(k).alphax =0;
    pars(k).alphay =0;  
end

for i = 1:length(ICxb)
    k = k+1;
    pars(k) = par;
    pars(k).Name = sprintf('SingHopf_b5_%d', i);
    pars(k).lambda_0 = -0.2;
    pars(k).r = 0;
    pars(k).tspan = [2 0];
    pars(k).epsilon = 0.01;
    pars(k).v0= [ICxb(i) ; ICyb(i)];
    pars(k).alphax =0;
    pars(k).alphay =0;
end