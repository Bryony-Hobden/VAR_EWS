%% This script runs the numerical simualtions of the singular hopf, hopf and fold model for 
%% slow parameter ramping 

%% Start with a clean slate
close all
clear all
%% Start timer
tic

%% Deterministic (no noise) singular hopf parameters
run('Parameters.m')

%%
for i=1:length(pars)

    % run through each of the parameter values
    par=pars(i);

    % Call the function that runs the actual numerical simulation
    [var] = heun_integrator(par.system, par.v0, par);
    
    % Saving
    path = '../Data/';
    name = par.Name;
    file_name = [path name];

    save( [file_name '.mat'], 'par', 'var');

    % Stop timer
    toc

end
