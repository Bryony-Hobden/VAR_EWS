%% Make figure for effect of block size and subsampling

clear all
close all

%% Figure setup

x0 = 10;
y0 = 10;
width = 1100;
height = 900;

figure('Position',[x0,y0,width,height])


tl = tiledlayout(3,1,'TileSpacing','compact','Padding','compact');


%% Settings

names_bs = ["SingHopf_slowramp", "SH_small_bs", "SH_big_bs"];
names_sub = ["SingHopf_slowramp", "SH_small_sub", "SH_big_sub"];

lineStyles = {'-', '--', ':'};

colx = '#2580cf';
coly = '#cf25b8';

colA1 = '#ff8c00';
colA2 = '#4a048f';


%% ========================================================================
% PANEL 1: ORIGINAL FOLD SLOW RAMP TIME SERIES
% ========================================================================

ax1 = nexttile;
hold(ax1,'on')

load("../Data/SingHopf_slowramp.mat")

sub = par.sub;

vx = var.v(1,1:sub:end)';
vy = var.v(2,1:sub:end)';
vt = var.t(1,1:sub:end)';

dt = par.dt;
lambda = par.lambda_0/par.r;

plot(ax1,vt,vx, ...
    Color=colx, ...
    LineWidth=1.5)

plot(ax1,vt,vy, ...
    Color=coly, ...
    LineWidth=1.5)

xline(ax1,lambda, ...
    Color='black', ...
    LineStyle='--', ...
    LineWidth=1.2)

title(ax1, 'Singular Hopf - blocksize and subsampling experiments')

xlabel(ax1,'t')
ylabel(ax1,'System variable')

legend(ax1, ...
    '$x$', ...
    '$y$', ...
    'Interpreter','latex', ...
    'Location','eastoutside')

hold(ax1,'off')


%% ========================================================================
% ANALYTICAL EIGENVALUES
% ========================================================================

% Use Fold_slowramp trajectory

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

bs = par.blocksize;

Nblocks = floor(length(vvt)/bs);

wvtA = [];
eJA1R = [];
eJA2R = [];

for j = 1:Nblocks

    if vvt(j*bs) > lambda
        break
    end

    wvtA(j) = vvt(j*bs);

    wvx = vvx(j*bs);
    wvy = vvy(j*bs);

    JacA = feval(par.system_jac, ...
        wvtA(j), ...
        [wvx wvy], ...
        par);

    eJA = eig(JacA);

    eJA1R(j) = real(eJA(1));
    eJA2R(j) = real(eJA(2));

end


%% ========================================================================
% PANEL 2: DIFFERENT BLOCK SIZES
% ========================================================================

ax2 = nexttile;
hold(ax2,'on')

for i = 1:3

    load("../Data/" + names_bs(i) + ".mat")

    %% Extract data

    sub = par.sub;

    vx = var.v(1,1:sub:end)';
    vy = var.v(2,1:sub:end)';
    vt = var.t(1,1:sub:end)';

    dt = par.dt;
    bs = par.blocksize;

    %% Remove end of trajectory

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

    %% VAR analysis

    Nblocks = floor(length(vvt)/bs);

    wvt = [];
    eJ1R = [];
    eJ2R = [];

    for j = 1:Nblocks

        if vvt(j*bs) > lambda
            break
        end

        wvt(j) = vvt(j*bs);

        winvx = vvx((j-1)*bs+1:j*bs);
        winvy = vvy((j-1)*bs+1:j*bs);

        Mdl = varm(2,1);

        [EstMdl,~,~,~] = estimate(Mdl,[winvx' winvy']);

        ARmat = cell2mat(EstMdl.AR);

        Jac = logm(ARmat)/(sub*dt);

        eJ = eig(Jac);

        eJ1R(j) = real(eJ(1));
        eJ2R(j) = real(eJ(2));

    end

    %% Plot VAR eigenvalues

    plot(ax2,wvt,eJ1R, ...
        Color='red', ...
        LineStyle=lineStyles{i}, ...
        LineWidth=1.5)

    plot(ax2,wvt,eJ2R, ...
        Color='blue', ...
        LineStyle=lineStyles{i}, ...
        LineWidth=1.5)

end


%% Analytical eigenvalues

plot(ax2,wvtA,eJA1R, ...
    '*', ...
    Color=colA1, ...
    LineWidth=1.2)

plot(ax2,wvtA,eJA2R, ...
    '*', ...
    Color=colA2, ...
    LineWidth=1.2)


%% Dummy handles for legend

hFold = plot(ax2,nan,nan, ...
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


%% Panel 2 formatting

yline(ax2,0, ...
    Color='black', ...
    LineWidth=1)

xline(ax2,lambda, ...
    Color='black', ...
    LineStyle='--', ...
    LineWidth=1.2)

title(ax2,'Blocksize experiment')

xlabel(ax2,'t')
ylabel(ax2,'$\mathcal{R}(\mu_i)$', ...
    'Interpreter','latex')

legend(ax2, ...
    [hFold hSmall hBig hA1 hA2], ...
    {'Original blocksize', ...
     'Small blocksize', ...
     'Big blocksize', ...
     'Analytical $\mu_1$', ...
     'Analytical $\mu_2$'}, ...
    'Interpreter','latex', ...
    'Location','eastoutside')

hold(ax2,'off')


%% ========================================================================
% PANEL 3: DIFFERENT SUBSAMPLING RATES
% ========================================================================

ax3 = nexttile;
hold(ax3,'on')

for i = 1:3

    load("../Data/" + names_sub(i) + ".mat")

    %% Extract data

    sub = par.sub;

    vx = var.v(1,1:sub:end)';
    vy = var.v(2,1:sub:end)';
    vt = var.t(1,1:sub:end)';

    dt = par.dt;
    bs = par.blocksize;

    %% Remove end of trajectory

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

    %% VAR analysis

    Nblocks = floor(length(vvt)/bs);

    wvt = [];
    eJ1R = [];
    eJ2R = [];

    for j = 1:Nblocks

        if vvt(j*bs) > lambda
            break
        end

        wvt(j) = vvt(j*bs);

        winvx = vvx((j-1)*bs+1:j*bs);
        winvy = vvy((j-1)*bs+1:j*bs);

        Mdl = varm(2,1);

        [EstMdl,~,~,~] = estimate(Mdl,[winvx' winvy']);

        ARmat = cell2mat(EstMdl.AR);

        Jac = logm(ARmat)/(sub*dt);

        eJ = eig(Jac);

        eJ1R(j) = real(eJ(1));
        eJ2R(j) = real(eJ(2));

    end

    %% Plot VAR eigenvalues

    plot(ax3,wvt,eJ1R, ...
        Color='red', ...
        LineStyle=lineStyles{i}, ...
        LineWidth=1.5)

    plot(ax3,wvt,eJ2R, ...
        Color='blue', ...
        LineStyle=lineStyles{i}, ...
        LineWidth=1.5)

end


%% Analytical eigenvalues

plot(ax3,wvtA,eJA1R, ...
    '*', ...
    Color=colA1, ...
    LineWidth=1.2)

plot(ax3,wvtA,eJA2R, ...
    '*', ...
    Color=colA2, ...
    LineWidth=1.2)


%% Dummy handles for legend

hFold = plot(ax3,nan,nan, ...
    Color='black', ...
    LineStyle='-', ...
    LineWidth=1.5);

hSmall = plot(ax3,nan,nan, ...
    Color='black', ...
    LineStyle='--', ...
    LineWidth=1.5);

hBig = plot(ax3,nan,nan, ...
    Color='black', ...
    LineStyle=':', ...
    LineWidth=1.5);

hA1 = plot(ax3,nan,nan, ...
    '*', ...
    Color=colA1, ...
    LineWidth=1.2);

hA2 = plot(ax3,nan,nan, ...
    '*', ...
    Color=colA2, ...
    LineWidth=1.2);


%% Panel 3 formatting

yline(ax3,0, ...
    Color='black', ...
    LineWidth=1)

xline(ax3,lambda, ...
    Color='black', ...
    LineStyle='--', ...
    LineWidth=1.2)

title(ax3,'Subsampling experiment')

xlabel(ax3,'t')
ylabel(ax3,'$\mathcal{R}(\mu_i)$', ...
    'Interpreter','latex')

legend(ax3, ...
    [hFold hSmall hBig hA1 hA2], ...
    {'Original subsampling', ...
     'Small subsampling', ...
     'Big subsampling', ...
     'Analytical $\mu_1$', ...
     'Analytical $\mu_2$'}, ...
    'Interpreter','latex', ...
    'Location','eastoutside')

hold(ax3,'off')


%% ========================================================================
% LINK X AXES
% ========================================================================

linkaxes([ax1 ax2 ax3],'x')

exportgraphics(gcf,'..\Figures\SingHopf_VAR_bssub_comparison.png','ContentType','vector')