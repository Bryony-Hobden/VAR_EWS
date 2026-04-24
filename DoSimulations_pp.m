%% This script runs the numerical simualtions to produce the phase portraits for singular Hopf, Hopf and fold

%% Start with a clean slate
close all
clear all
%% Start timer
tic
%% 
parfilenames = {
    'Parameters_ppSingHopf.m'
    'Parameters_ppFold.m'
    'Parameters_ppHopf.m'
    };

%%
for j =1:length(parfilenames)

    run(parfilenames{j})

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
end

