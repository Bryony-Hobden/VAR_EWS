% Make fold figures for VAR
clear all
close all

%% Figure setup

x0 = 10;
y0 = 10;
width = 1100;
height = 800;

figure('Position',[x0,y0,width,height])

tl = tiledlayout(2,1,'TileSpacing','compact','Padding','compact');


%% Define simulations

names = ["SingHopf_slowramp", "SH_small_noise", "SH_big_noise"];

% Line styles for the three simulations
lineStyles = {'-', '--', ':'};

% Colours
colx = '#2580cf';
coly = '#cf25b8';
colA1 = '#ff8c00';
colA2 = '#4a048f';


%% Store VAR results

VARresults = cell(1,3);


%% ========================================================================
% TOP PANEL: TIME SERIES
% ========================================================================

ax1 = nexttile;
hold(ax1,'on')
title('Singular Hopf - noise experiments')


for i = 1:length(names)

    %% Load data

    load("../Data/" + names(i) + ".mat")

    sub = par.sub;

    vx = var.v(1,1:sub:end)';
    vy = var.v(2,1:sub:end)';
    vt = var.t(1,1:sub:end)';


    %% Remove end of trajectory if it escapes into relaxation oscillation

    if par.plot == 1 || par.plot == 3
        thresh = 1.1;
    else
        thresh = 1.5;
    end

    j = 1;
    lvt = length(vt);

    vvx = [];
    vvy = [];
    vvt = [];

    while j < lvt && ...
            abs(vx(j)) < thresh && ...
            abs(vy(j)) < thresh

        vvx(j) = vx(j);
        vvy(j) = vy(j);
        vvt(j) = vt(j);

        j = j + 1;
    end


    %% Plot time series

    plot(ax1,vvt,vvx, ...
        Color=colx, ...
        LineWidth=1.5, ...
        LineStyle=lineStyles{i})

    plot(ax1,vvt,vvy, ...
        Color=coly, ...
        LineWidth=1.5, ...
        LineStyle=lineStyles{i})


    %% ====================================================================
    % VAR ANALYSIS
    % ====================================================================

    dt = par.dt;
    bs = par.blocksize;

    % Reset arrays for this simulation

    wvt = [];
    wvx = [];
    wvy = [];

    eJ1R = [];
    eJ2R = [];

    eJA1R = [];
    eJA2R = [];

    Nblocks = floor(length(vvt)/bs);


    %% Loop over blocks

    if Nblocks >= 1

        for j = 1:Nblocks

            %% End of each block

            wvt(j) = vvt(j*bs);
            wvx(j) = vvx(j*bs);
            wvy(j) = vvy(j*bs);


            %% Data within block

            winvx = vvx((j-1)*bs+1:j*bs);
            winvy = vvy((j-1)*bs+1:j*bs);


            %% Fit VAR(1)

            Mdl = varm(2,1);

            [EstMdl,EstSE,logL,Tbl1] = ...
                estimate(Mdl,[winvx' winvy']);


            %% Extract AR matrix

            ARmat = cell2mat(EstMdl.AR);


            %% Calculate Jacobian from VAR matrix

            Jac = logm(ARmat)/(sub*dt);

            eJ = eig(Jac);

            eJ1R(j) = real(eJ(1));
            eJ2R(j) = real(eJ(2));


            %% Calculate analytical Jacobian

            JacA = feval(par.system_jac, ...
                wvt(j), ...
                [wvx(j) wvy(j)], ...
                par);

            eJA = eig(JacA);

            eJA1R(j) = real(eJA(1));
            eJA2R(j) = real(eJA(2));

        end

    end


    %% ====================================================================
    % STORE RESULTS FOR THIS SIMULATION
    % ====================================================================

    VARresults{i}.wvt = wvt;

    % VAR eigenvalues
    VARresults{i}.eJ1R = eJ1R;
    VARresults{i}.eJ2R = eJ2R;

    % Analytical eigenvalues
    VARresults{i}.eJA1R = eJA1R;
    VARresults{i}.eJA2R = eJA2R;

    % Critical point / dashed vertical line
    VARresults{i}.lambda = par.lambda_0/par.r;

end


%% ========================================================================
% FORMAT TOP PANEL
% ========================================================================

xline(ax1,VARresults{1}.lambda, ...
    Color='black', ...
    LineWidth=1.5, ...
    LineStyle='--')

ylabel(ax1,'System Variable','FontSize',11)

xlabel(ax1,'t')


%% Top-panel legend
% Colour = variable
% Line style = experiment

hX = plot(ax1,nan,nan, ...
    Color=colx, ...
    LineStyle='-', ...
    LineWidth=1.5);

hY = plot(ax1,nan,nan, ...
    Color=coly, ...
    LineStyle='-', ...
    LineWidth=1.5);

hSlow = plot(ax1,nan,nan, ...
    Color='black', ...
    LineStyle='-', ...
    LineWidth=1.5);

hSmall = plot(ax1,nan,nan, ...
    Color='black', ...
    LineStyle='--', ...
    LineWidth=1.5);

hBig = plot(ax1,nan,nan, ...
    Color='black', ...
    LineStyle=':', ...
    LineWidth=1.5);

legend(ax1,[hX hY hSlow hSmall hBig], ...
    {'$x$ variable','$y$ variable', ...
     'Original noise','Small noise','Big noise'}, ...
    'Interpreter','latex', ...
    'Location','eastoutside', ...
    'FontSize',10)

hold(ax1,'off')


%% ========================================================================
% BOTTOM PANEL: VAR ANALYSIS
% ========================================================================

ax2 = nexttile;
hold(ax2,'on')


for i = 1:3

    %% Retrieve results

    wvt = VARresults{i}.wvt;

    eJ1R = VARresults{i}.eJ1R;
    eJ2R = VARresults{i}.eJ2R;

    eJA1R = VARresults{i}.eJA1R;
    eJA2R = VARresults{i}.eJA2R;

    lambda = VARresults{i}.lambda;


    %% Only plot VAR results before the critical point

    keep = wvt <= lambda;

    wvt_plot = wvt(keep);

    eJ1R_plot = eJ1R(keep);
    eJ2R_plot = eJ2R(keep);

    eJA1R_plot = eJA1R(keep);
    eJA2R_plot = eJA2R(keep);


    %% VAR eigenvalue estimates

    plot(ax2,wvt_plot,eJ1R_plot, ...
        Color='blue', ...
        LineWidth=1.5, ...
        LineStyle=lineStyles{i})

    plot(ax2,wvt_plot,eJ2R_plot, ...
        Color='red', ...
        LineWidth=1.5, ...
        LineStyle=lineStyles{i})


    %% Analytical eigenvalues

    plot(ax2,wvt_plot,eJA1R_plot, ...
        '*', ...
        Color=colA1, ...
        LineWidth=1.2)

    plot(ax2,wvt_plot,eJA2R_plot, ...
        '*', ...
        Color=colA2, ...
        LineWidth=1.2)

end


%% ========================================================================
% ZERO LINE
% ========================================================================

yline(ax2,0, ...
    Color='black', ...
    LineWidth=1)


%% ========================================================================
% CRITICAL POINT
% ========================================================================

xline(ax2,VARresults{1}.lambda, ...
    Color='black', ...
    LineWidth=1.5, ...
    LineStyle='--')


%% ========================================================================
% LABELS
% ========================================================================

xlabel(ax2,'t')

ylabel(ax2,'$\mathcal{R}(\mu_i)$', ...
    'Interpreter','latex')


%% ========================================================================
% BOTTOM-PANEL LEGEND
% ========================================================================
% Line style = experiment
% Star colour = analytical eigenvalue

hSlow = plot(ax2,nan,nan, ...
    Color='black', ...
    LineStyle='-', ...
    LineWidth=1.5);

hSmall = plot(ax2,nan,nan, ...
    Color='black', ...
    LineStyle='--', ...
    LineWidth=1.5);

hBig = plot(ax2,nan,nan, ...
    Color='black', ...
    LineStyle=':', ...
    LineWidth=1.5);

hA1 = plot(ax2,nan,nan, ...
    '*', ...
    Color=colA1, ...
    LineWidth=1.2);

hA2 = plot(ax2,nan,nan, ...
    '*', ...
    Color=colA2, ...
    LineWidth=1.2);

legend(ax2,[hSlow hSmall hBig hA1 hA2], ...
    {'Original noise','Small noise','Big noise', ...
     'Analytical $\mu_1$','Analytical $\mu_2$'}, ...
    'Interpreter','latex', ...
    'Location','eastoutside', ...
    'FontSize',10)

hold(ax2,'off')


%% Link x-axes

linkaxes([ax1 ax2],'x')

exportgraphics(gcf,'..\Figures\SingHopf_VAR_noise_comparison.png','ContentType','vector')