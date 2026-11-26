%% Make fold figures for VAR

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

names = ["HOrig_r", "H_small_r", "H_big_r"];

% Line styles for the three simulations
lineStyles = {'-', '--', ':'};

colx = '#2580cf';
coly = '#cf25b8';

colA1 = '#ff8c00';
colA2 = '#4a048f';


%% ========================================================================
% TOP PANEL: TIME SERIES
% ========================================================================

ax1 = nexttile;
hold(ax1,'on')


for i = 1:3

    %% Load data

    load("../Data/" + names(i) + ".mat")

    sub = par.sub;

    vx = var.v(1,1:sub:end)';
    vy = var.v(2,1:sub:end)';
    vt = var.t(1,1:sub:end)';


    %% Remove end of trajectory for VAR analysis if it escapes
    % into relaxation oscillation
    %
    % The FULL trajectory is retained for plotting.
    % vvx/vvy/vvt contain only the part used for VAR analysis.

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


    %% Plot FULL time series

    plot(ax1,vt,vx, ...
        Color=colx, ...
        LineWidth=1.5, ...
        LineStyle=lineStyles{i})

    plot(ax1,vt,vy, ...
        Color=coly, ...
        LineWidth=1.5, ...
        LineStyle=lineStyles{i})


    %% ====================================================================
    % VAR ANALYSIS
    % ====================================================================

    dt = par.dt;
    bs = par.blocksize;

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

            [EstMdl,~,~,~] = ...
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
    % CRITICAL POINT FOR THIS RAMP
    % ====================================================================

    lambda = par.lambda_0/par.r;


    %% Only plot VAR results before the critical point

    keep = wvt <= lambda;

    wvt_plot = wvt(keep);

    eJ1R_plot = eJ1R(keep);
    eJ2R_plot = eJ2R(keep);

    eJA1R_plot = eJA1R(keep);
    eJA2R_plot = eJA2R(keep);


    %% Store results

    if i == 1

        wvt1 = wvt_plot;
        eJ11 = eJ1R_plot;
        eJ21 = eJ2R_plot;
        eJA11 = eJA1R_plot;
        eJA21 = eJA2R_plot;

        lambda1 = lambda;

    elseif i == 2

        wvt2 = wvt_plot;
        eJ12 = eJ1R_plot;
        eJ22 = eJ2R_plot;
        eJA12 = eJA1R_plot;
        eJA22 = eJA2R_plot;

        lambda2 = lambda;

    elseif i == 3

        wvt3 = wvt_plot;
        eJ13 = eJ1R_plot;
        eJ23 = eJ2R_plot;
        eJA13 = eJA1R_plot;
        eJA23 = eJA2R_plot;

        lambda3 = lambda;

    end

end


%% ========================================================================
% FORMAT TOP PANEL
% ========================================================================

% Original r
xline(ax1,lambda1, ...
    Color='black', ...
    LineWidth=1.5, ...
    LineStyle='-')

% Small r
xline(ax1,lambda2, ...
    Color='black', ...
    LineWidth=1.5, ...
    LineStyle='--')

% Big r
xline(ax1,lambda3, ...
    Color='black', ...
    LineWidth=1.5, ...
    LineStyle=':')


title(ax1,'Subcritical Hopf - ramping experiments')

ylabel(ax1,'System Variable','FontSize',11)

xlabel(ax1,'t')


%% Plotting horizon

xlim(ax1,[0 700])


%% Dummy handles for top-panel legend

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
    {'$x$ variable', ...
     '$y$ variable', ...
     'Original $r$', ...
     'Small $r$', ...
     'Big $r$'}, ...
    'Interpreter','latex', ...
    'Location','eastoutside', ...
    'FontSize',10)


%% ========================================================================
% BOTTOM PANEL: VAR ANALYSIS
% ========================================================================

ax2 = nexttile;
hold(ax2,'on')


%% Slow ramp

plot(ax2,wvt1,eJ11, ...
    Color='blue', ...
    LineWidth=1.5, ...
    LineStyle='-')

plot(ax2,wvt1,eJ21, ...
    Color='red', ...
    LineWidth=1.5, ...
    LineStyle='-')


%% Small r

plot(ax2,wvt2,eJ12, ...
    Color='blue', ...
    LineWidth=1.5, ...
    LineStyle='--')

plot(ax2,wvt2,eJ22, ...
    Color='red', ...
    LineWidth=1.5, ...
    LineStyle='--')


%% Big r

plot(ax2,wvt3,eJ13, ...
    Color='blue', ...
    LineWidth=1.5, ...
    LineStyle=':')

plot(ax2,wvt3,eJ23, ...
    Color='red', ...
    LineWidth=1.5, ...
    LineStyle=':')


%% ========================================================================
% ANALYTICAL EIGENVALUES
% ========================================================================

% Original r

plot(ax2,wvt1,eJA11, ...
    '*', ...
    Color=colA1, ...
    LineWidth=1.2)

plot(ax2,wvt1,eJA21, ...
    '*', ...
    Color=colA2, ...
    LineWidth=1.2)


% Small r

plot(ax2,wvt2,eJA12, ...
    '*', ...
    Color=colA1, ...
    LineWidth=1.2)

plot(ax2,wvt2,eJA22, ...
    '*', ...
    Color=colA2, ...
    LineWidth=1.2)


% Big r

plot(ax2,wvt3,eJA13, ...
    '*', ...
    Color=colA1, ...
    LineWidth=1.2)

plot(ax2,wvt3,eJA23, ...
    '*', ...
    Color=colA2, ...
    LineWidth=1.2)


%% ========================================================================
% ZERO LINE
% ========================================================================

yline(ax2,0, ...
    Color='black', ...
    LineWidth=1)


%% ========================================================================
% CRITICAL POINTS
% ========================================================================

% Original r
xline(ax2,lambda1, ...
    Color='black', ...
    LineWidth=1.5, ...
    LineStyle='-')

% Small r
xline(ax2,lambda2, ...
    Color='black', ...
    LineWidth=1.5, ...
    LineStyle='--')

% Big r
xline(ax2,lambda3, ...
    Color='black', ...
    LineWidth=1.5, ...
    LineStyle=':')


%% ========================================================================
% LABELS
% ========================================================================


xlabel(ax2,'t')

ylabel(ax2,'$\mathcal{R}(\mu_i)$', ...
    'Interpreter','latex')


%% ========================================================================
% DUMMY HANDLES FOR LEGEND
% ========================================================================

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


%% ========================================================================
% LEGEND
% ========================================================================

legend(ax2, ...
    [hSlow hSmall hBig hA1 hA2], ...
    {'Original $r$', ...
     'Small $r$', ...
     'Big $r$', ...
     'Analytical $\mu_1$', ...
     'Analytical $\mu_2$'}, ...
    'Interpreter','latex', ...
    'Location','eastoutside', ...
    'FontSize',10)


%% ========================================================================
% AXIS LIMITS
% ========================================================================

xlim(ax2,[0 700])


%% ========================================================================
% LINK X-AXES
% ========================================================================

linkaxes([ax1 ax2],'x')

hold(ax2,'off')

exportgraphics(gcf,'..\Figures\Hopf_VAR_ramp_comparison.png','ContentType','vector')