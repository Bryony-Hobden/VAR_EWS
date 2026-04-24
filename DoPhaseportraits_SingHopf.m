clear all
close all
% Run this script to produce the phase portraits for the singular Hopf
% system
%% Sing Hopf stable
load('../Data/SingHopf_1_traj');

Dfolder = '../Data/';
Ffolder = '../Figures/';

x = linspace(-1.5, 1, 10000);
f = @(x)((x.^2).*(1+x));
y = f(x);

vx_traj = var.v(1,:);
vy_traj = var.v(2,:);

ICx = [0.6 0.6 0.6 -1.2 -1.2 0.17 0.23 -0.6 0 -0.25 0.6];
ICy = [0.18 0 -0.02 0.1 0.2 0.058 0.038 0.05 0.2 0.1 -0.08];

ICxb = [-0.6 0 -0.25];
ICyb = [0.05 0.2 0.1];

% Fixed point
x_fp = par.lambda_0;
y_fp = (par.lambda_0^2)*(1 + par.lambda_0);

% Zoom window
dx = 0.04;
dy = 0.02;

% Patch for oscillatory behaviour
lb = (-1+sqrt(1-6*sqrt(par.epsilon)))/3;

close all
figure()
set(gca,'Layer','top')
set(gcf, 'Position', [10 10 750 600])
hold on
%oscillatory region
rectangle('Position', [(-1+sqrt(1-6*sqrt(par.epsilon)))/3, -0.1, -(-1+sqrt(1-6*sqrt(par.epsilon)))/3 + (-1+sqrt(1+6*sqrt(par.epsilon)))/3, 0.6], 'FaceColor', [0.4 0.6 0.8], EdgeColor='none', FaceAlpha=0.3)
% Critical manifold
plot(x, y, 'k', 'LineWidth',2.5)
scatter([0,-2/3], [0, 4/27], 'filled','o', 'MarkerFaceColor','#000000')
% axis labels
xlabel('x')
ylabel('y')
% axis limits
xlim([-1.2, 0.6])
ylim([-0.1, 0.5])

%plot lambda vertical
plot([par.lambda_0 par.lambda_0], [-2 2], ...
    'Color','#cf25b8','LineWidth',2.5);

% vertical line x = 0
hX0 = plot([0 0], ylim, 'k', 'LineWidth', 1);
% horizontal line y = 0
hY0 = plot(xlim, [0 0], 'k', 'LineWidth', 1);
% push them behind everything
uistack(hX0,'bottom')
uistack(hY0,'bottom')

%set grid behind
grid on
set(gca,'Layer','bottom')
% Trajectories
IC  = [ICx(:),  ICy(:)];
ICb = [ICxb(:), ICyb(:)];
tol = 1e-10;
isDuplicate = @(p, Q) any(all(abs(Q - p) < tol, 2));

for i = 1:length(ICx)
    filename = sprintf('../Data/SingHopf_1_%d', i);
    load(filename)

    plot(var.v(1,:), var.v(2,:), 'LineWidth',1.5, 'Color','#2580cf')

    % Only plot scatter if NOT in ICxb / ICyb
    if ~isDuplicate([ICx(i), ICy(i)], ICb)
        ics = scatter(par.v0(1), par.v0(2), 'filled', ...
            'o', 'MarkerFaceColor','#2580cf');
        uistack(ics,'top')
    end
end
for i = 1:length(ICxb)
    filename = sprintf('../Data/SingHopf_b1_%d', i);
    load(filename)
    plot(var.v(1,:), var.v(2,:), 'LineWidth',1.5, 'Color','#2580cf')
end
% Fixed point
plot(x_fp, y_fp, 'ko', ...
    'MarkerFaceColor','#13ed43', ...
    'MarkerEdgeColor','#13ed43', ...
    'MarkerSize',6, 'LineWidth',2);
% Zoom box on main axes
rectangle(gca, ...
    'Position',[x_fp-dx, y_fp-dy, 2*dx, 2*dy], ...
    'EdgeColor','k', 'LineWidth',0.9)

% ===================== Inset =====================
ax_main = gca;
ax_main.TickDir = 'out';
ax_in = axes('Position',[0.2 0.63 0.3 0.27]);
box on
hold(ax_in,'on')

copyobj(allchild(ax_main), ax_in)

xlim(ax_in,[x_fp-dx x_fp+dx])
ylim(ax_in,[y_fp-dy y_fp+dy])

set(ax_in, ...
    'FontSize',8, ...
    'LineWidth',0.8, ...
    'TickDir','in', ...
    'XMinorTick','off', ...
    'YMinorTick','off',...
    'LooseInset', max(get(ax_in,'TightInset'), 0.01))

ax_in.XTick = linspace(x_fp-dx, x_fp+dx, 3);
ax_in.YTick = linspace(y_fp-dy, y_fp+dy, 3);
hold off

% ===================== Save =====================
savefig([Ffolder 'SingHopfpp1.fig'])
exportgraphics(gcf, [Ffolder 'SingHopfpp1.png'], 'ContentType','vector')

%% Sing Hopf stable spiral
load('../Data/SingHopf_2_traj');

Dfolder = '../Data/';
Ffolder = '../Figures/';

x = linspace(-1.5, 1, 10000);
f = @(x)((x.^2).*(1+x));
y = f(x);

vx_traj = var.v(1,:);
vy_traj = var.v(2,:);

% Initial conditions
ICx = [0.6 0.6 0.6 -1.2 -0.6 -0.25 -1.2 0.035 0];
ICy = [0.18 0.1 -0.08 0.1 0.05 0.1 0.2 2.625e-3 0.2];

ICxb = [-0.6 0 -0.25];
ICyb = [0.05 0.2 0.1];

% Fixed point
x_fp = par.lambda_0;
y_fp = (par.lambda_0^2)*(1 + par.lambda_0);

% Zoom window
dx = 0.015;
dy = 2e-3;

figure()
set(gca,'Layer','top')
set(gcf, 'Position', [10 10 750 600])
hold on
rectangle('Position', [(-1+sqrt(1-6*sqrt(par.epsilon)))/3, -0.1, -(-1+sqrt(1-6*sqrt(par.epsilon)))/3 + (-1+sqrt(1+6*sqrt(par.epsilon)))/3, 0.6], 'FaceColor', [0.4 0.6 0.8], EdgeColor='none', FaceAlpha=0.3);
plot([par.lambda_0 par.lambda_0], [-2 2], ...
    'Color','#cf25b8','LineWidth',2.5);
% Critical manifold
plot(x, y, 'k', 'LineWidth',2.5)
scatter([0,-2/3], [0, 4/27], 'filled','o', 'MarkerFaceColor','#000000')
xlabel('x')
ylabel('y')
xlim([-1.2, 0.6])
ylim([-0.1, 0.5])
% vertical line x = 0
hX0 = plot([0 0], ylim, 'k', 'LineWidth', 1);
% horizontal line y = 0
hY0 = plot(xlim, [0 0], 'k', 'LineWidth', 1);
% push them behind everything
uistack(hX0,'bottom')
uistack(hY0,'bottom')
grid on
set(gca,'Layer','bottom')

% Trajectories
IC  = [ICx(:),  ICy(:)];
ICb = [ICxb(:), ICyb(:)];
tol = 1e-10;
isDuplicate = @(p, Q) any(all(abs(Q - p) < tol, 2));

for i = 1:length(ICx)
    filename = sprintf('../Data/SingHopf_2_%d', i);
    load(filename)

    plot(var.v(1,:), var.v(2,:), 'LineWidth',1.5, 'Color','#2580cf')

    % Only plot scatter if NOT in ICxb / ICyb
    if ~isDuplicate([ICx(i), ICy(i)], ICb)
        ics = scatter(par.v0(1), par.v0(2), 'filled', ...
            'o', 'MarkerFaceColor','#2580cf');
        uistack(ics,'top')
    end
end
for i = 1:length(ICxb)
    filename = sprintf('../Data/SingHopf_b2_%d', i);
    load(filename)
    plot(var.v(1,:), var.v(2,:), 'LineWidth',1.5, 'Color','#2580cf')
end
% Fixed point
plot(x_fp, y_fp, 'ko', ...
    'MarkerFaceColor','#13ed43', ...
    'MarkerEdgeColor','#13ed43', ...
    'MarkerSize',6, 'LineWidth',2);
% % Zoom box on main axes
% rectangle(gca, ...
%     'Position',[x_fp-dx, y_fp-dy, 2*dx, 2*dy], ...
%     'EdgeColor','k', 'LineWidth',0.9)

% ===================== Inset =====================
ax_main = gca;
ax_main.TickDir = 'out';
ax_in = axes('Position',[0.2 0.63 0.3 0.27]);
box on
hold(ax_in,'on')

copyobj(allchild(ax_main), ax_in)

xlim(ax_in,[x_fp-dx x_fp+dx])
ylim(ax_in,[y_fp-dy y_fp+dy])

set(ax_in, ...
    'FontSize',8, ...
    'LineWidth',0.8, ...
    'TickDir','in', ...
    'XMinorTick','off', ...
    'YMinorTick','off',...
    'LooseInset', max(get(ax_in,'TightInset'), 0.01))

ax_in.XTick = linspace(x_fp-dx, x_fp+dx, 3);
ax_in.YTick = linspace(y_fp-dy, y_fp+dy, 3);
hold off

% ===================== Save =====================
savefig([Ffolder 'SingHopfpp2.fig'])
exportgraphics(gcf, [Ffolder 'SingHopfpp2.png'], 'ContentType','vector')

%% centres
load('../Data/SingHopf_3_traj');

Dfolder = '../Data/';
Ffolder = '../Figures/';

x = linspace(-1.5, 1, 10000);
f = @(x)((x.^2).*(1+x));
y = f(x);

vx_traj = var.v(1,:);
vy_traj = var.v(2,:);

% Initial conditions
ICx = [0.6 0.6 0.6 -1.2 -0.6 -0.25 -1.2 0];
ICy = [0.18 0.1 -0.08 0.1 0.05 0.1 0.2 0.2];

ICxb = [-0.6 0 -0.25];
ICyb = [0.05 0.2 0.1];


% Fixed point
x_fp = par.lambda_0;
y_fp = (par.lambda_0^2)*(1 + par.lambda_0);

% Zoom window
dx = 0.1;
dy = 0.02;

figure()
set(gca,'Layer','top')
set(gcf, 'Position', [10 10 750 600])
hold on
rectangle('Position', [(-1+sqrt(1-6*sqrt(par.epsilon)))/3, -0.1, -(-1+sqrt(1-6*sqrt(par.epsilon)))/3 + (-1+sqrt(1+6*sqrt(par.epsilon)))/3, 0.6], 'FaceColor', [0.4 0.6 0.8], EdgeColor='none', FaceAlpha=0.3);
plot([par.lambda_0 par.lambda_0], [-2 2], ...
    'Color','#cf25b8','LineWidth',2.5);
% Critical manifold
plot(x, y, 'k', 'LineWidth',2.5)
scatter([0,-2/3], [0, 4/27], 'filled','o', 'MarkerFaceColor','#000000')
xlabel('x')
ylabel('y')
xlim([-1.2, 0.6])
ylim([-0.1, 0.5])
yl = ylim;  % get limits later if needed
hVL = plot([par.lambda_0 par.lambda_0], [-2 2], ...
    'Color','#cf25b8','LineWidth',2.5);
uistack(hVL,'bottom')   % push vertical line behind everything
% vertical line x = 0
hX0 = plot([0 0], ylim, 'k', 'LineWidth', 1);
% horizontal line y = 0
hY0 = plot(xlim, [0 0], 'k', 'LineWidth', 1);
% push them behind everything
uistack(hX0,'bottom')
uistack(hY0,'bottom')
grid on
set(gca,'Layer','bottom')
% Trajectories
IC  = [ICx(:),  ICy(:)];
ICb = [ICxb(:), ICyb(:)];
tol = 1e-10;
isDuplicate = @(p, Q) any(all(abs(Q - p) < tol, 2));

for i = 1:length(ICx)
    filename = sprintf('../Data/SingHopf_3_%d', i);
    load(filename)

    plot(var.v(1,:), var.v(2,:), 'LineWidth',1.5, 'Color','#2580cf')

    % Only plot scatter if NOT in ICxb / ICyb
    if ~isDuplicate([ICx(i), ICy(i)], ICb)
        ics = scatter(par.v0(1), par.v0(2), 'filled', ...
            'o', 'MarkerFaceColor','#2580cf');
        uistack(ics,'top')
    end
end
for i = 1:length(ICxb)
    filename = sprintf('../Data/SingHopf_b3_%d', i);
    load(filename)
    plot(var.v(1,:), var.v(2,:), 'LineWidth',1.5, 'Color','#2580cf')
end
% Fixed point
plot(x_fp, y_fp, 'ko', ...
    'MarkerFaceColor','#cf25b8', ...
    'MarkerEdgeColor','#cf25b8', ...
    'MarkerSize',6, 'LineWidth',2);
% Zoom box on main axes
rectangle(gca, ...
    'Position',[x_fp-dx, y_fp-dy, 2*dx, 2*dy], ...
    'EdgeColor','k', 'LineWidth',0.9)

% ===================== Inset =====================
ax_main = gca;
ax_main.TickDir = 'out';
ax_in = axes('Position',[0.2 0.63 0.3 0.27]);
box on
hold(ax_in,'on')

copyobj(allchild(ax_main), ax_in)

xlim(ax_in,[x_fp-dx x_fp+dx])
ylim(ax_in,[y_fp-dy y_fp+dy])

set(ax_in, ...
    'FontSize',8, ...
    'LineWidth',0.8, ...
    'TickDir','in', ...
    'XMinorTick','off', ...
    'YMinorTick','off',...
    'LooseInset', max(get(ax_in,'TightInset'), 0.01))

ax_in.XTick = linspace(x_fp-dx, x_fp+dx, 3);
ax_in.YTick = linspace(y_fp-dy, y_fp+dy, 3);
hold off

% ===================== Save =====================
savefig([Ffolder 'SingHopfpp3.fig'])
exportgraphics(gcf, [Ffolder 'SingHopfpp3.png'], 'ContentType','vector')

%% unstable spiral
load('../Data/SingHopf_4_traj');

Dfolder = '../Data/';
Ffolder = '../Figures/';

x = linspace(-1.5, 1, 10000);
f = @(x)((x.^2).*(1+x));
y = f(x);

vx_traj = var.v(1,:);
vy_traj = var.v(2,:);

% Initial conditions
ICx = [0.6 0.6 0.6 -1.2 -0.6 -0.25 -1.2 -0.05-0.00001 -0.05+0.00001 0];
ICy = [0.18 0.1 -0.08 0.1 0.05 0.1 0.2 0.0024+0.00001 0.0024-0.00001 0.2];

ICxb = [-0.6 0 -0.25];
ICyb = [0.05 0.2 0.1];


% Fixed point
x_fp = par.lambda_0;
y_fp = (par.lambda_0^2)*(1 + par.lambda_0);

% Zoom window
dx = 0.006;
dy = 1.1e-3;

figure()
set(gca,'Layer','top')
set(gcf, 'Position', [10 10 750 600])
hold on
rectangle('Position', [(-1+sqrt(1-6*sqrt(par.epsilon)))/3, -0.1, -(-1+sqrt(1-6*sqrt(par.epsilon)))/3 + (-1+sqrt(1+6*sqrt(par.epsilon)))/3, 0.6], 'FaceColor', [0.4 0.6 0.8], EdgeColor='none', FaceAlpha=0.3);
plot([par.lambda_0 par.lambda_0], [-2 2], ...
    'Color','#cf25b8','LineWidth',2.5);
% Critical manifold
plot(x, y, 'k', 'LineWidth',2.5)
scatter([0,-2/3], [0, 4/27], 'filled','o', 'MarkerFaceColor','#000000')
xlabel('x')
ylabel('y')
% Trajectories
IC  = [ICx(:),  ICy(:)];
ICb = [ICxb(:), ICyb(:)];
tol = 1e-10;
isDuplicate = @(p, Q) any(all(abs(Q - p) < tol, 2));

for i = 1:length(ICx)
    filename = sprintf('../Data/SingHopf_4_%d', i);
    load(filename)

    plot(var.v(1,:), var.v(2,:), 'LineWidth',1.5, 'Color','#2580cf')

    % Only plot scatter if NOT in ICxb / ICyb
    if ~isDuplicate([ICx(i), ICy(i)], ICb)
        ics = scatter(par.v0(1), par.v0(2), 'filled', ...
            'o', 'MarkerFaceColor','#2580cf');
        uistack(ics,'top')
    end
    if i==length(ICx)
        plot(var.v(1,end-13000:end), var.v(2, end-13000:end), LineWidth=1.5, Color='#13ed43')
    end
end
for i = 1:length(ICxb)
    filename = sprintf('../Data/SingHopf_b4_%d', i);
    load(filename)
    plot(var.v(1,:), var.v(2,:), 'LineWidth',1.5, 'Color','#2580cf')
end
% Fixed point
plot(x_fp, y_fp, 'ko', ...
    'MarkerFaceColor','r', ...
    'MarkerEdgeColor','r', ...
    'MarkerSize',6, 'LineWidth',2)
xlim([-1.2, 0.6])
ylim([-0.1, 0.5])
% vertical line x = 0
hX0 = plot([0 0], ylim, 'k', 'LineWidth', 1);
% horizontal line y = 0
hY0 = plot(xlim, [0 0], 'k', 'LineWidth', 1);
% push them behind everything
uistack(hX0,'bottom')
uistack(hY0,'bottom')
grid on
set(gca,'Layer','bottom')
% Zoom box on main axes
% rectangle(gca, ...
%     'Position',[x_fp-dx, y_fp-dy, 2*dx, 2*dy], ...
%     'EdgeColor','k', 'LineWidth',0.9)

% ===================== Inset =====================
ax_main = gca;
ax_main.TickDir = 'out';
ax_in = axes('Position',[0.2 0.63 0.3 0.27]);
box on
hold(ax_in,'on')

copyobj(allchild(ax_main), ax_in)

xlim(ax_in,[x_fp-dx x_fp+dx])
ylim(ax_in,[y_fp-dy y_fp+dy])

set(ax_in, ...
    'FontSize',8, ...
    'LineWidth',0.8, ...
    'TickDir','in', ...
    'XMinorTick','off', ...
    'YMinorTick','off',...
    'LooseInset', max(get(ax_in,'TightInset'), 0.01))

ax_in.XTick = linspace(x_fp-dx, x_fp+dx, 3);
ax_in.YTick = linspace(y_fp-dy, y_fp+dy, 3);
hold off

% ===================== Save =====================
savefig([Ffolder 'SingHopfpp4.fig'])
exportgraphics(gcf, [Ffolder 'SingHopfpp4.png'], 'ContentType','vector')
%%
load('../Data/SingHopf_5_traj');

Dfolder = '../Data/';
Ffolder = '../Figures/';

x = linspace(-1.5, 1, 10000);
f = @(x)((x.^2).*(1+x));
y = f(x);

vx_traj = var.v(1,:);
vy_traj = var.v(2,:);

% Vector field
x_vec = linspace(-1.2, 0.6, 20);
y_vec = linspace(-0.1, 0.5, 20);
[X, Y] = meshgrid(x_vec, y_vec);

U = (1/par.epsilon)*(Y - (X.^2 .* (1+X)));
V = par.lambda_0 - X;

% Initial conditions
ICx = [0.6 0.6 0.6 -1.2 -0.6 -0.25 -1.2 -0.2-0.001 -0.2+0.001 0];
ICy = [0.18 0.1 -0.08 0.1 0.05 0.1 0.2 0.032+0.001 0.032-0.001 0.2];

ICxb = [-0.6 0 -0.25];
ICyb = [0.05 0.2 0.1];


% Fixed point
x_fp = par.lambda_0;
y_fp = (par.lambda_0^2)*(1 + par.lambda_0);

% Zoom window
dx = 0.04;
dy = 0.02;

figure()
set(gcf, 'Position', [10 10 750 600])
hold on
rectangle('Position', [(-1+sqrt(1-6*sqrt(par.epsilon)))/3, -0.1, -(-1+sqrt(1-6*sqrt(par.epsilon)))/3 + (-1+sqrt(1+6*sqrt(par.epsilon)))/3, 0.6], 'FaceColor', [0.4 0.6 0.8], EdgeColor='none', FaceAlpha=0.3);
plot([par.lambda_0 par.lambda_0], [-2 2], ...
    'Color','#cf25b8','LineWidth',2.5);
% Critical manifold
plot(x, y, 'k', 'LineWidth',2.5)
% Parameter lines
xlabel('x')
ylabel('y')
scatter([0,-2/3], [0, 4/27], 'filled','o', 'MarkerFaceColor','#000000')
% Trajectories
IC  = [ICx(:),  ICy(:)];
ICb = [ICxb(:), ICyb(:)];
tol = 1e-10;
isDuplicate = @(p, Q) any(all(abs(Q - p) < tol, 2));

for i = 1:length(ICx)
    filename = sprintf('../Data/SingHopf_5_%d', i);
    load(filename)

    plot(var.v(1,:), var.v(2,:), 'LineWidth',1.5, 'Color','#2580cf')

    % Only plot scatter if NOT in ICxb / ICyb
    if ~isDuplicate([ICx(i), ICy(i)], ICb)
        ics = scatter(par.v0(1), par.v0(2), 'filled', ...
            'o', 'MarkerFaceColor','#2580cf');
        uistack(ics,'top')
    end
    if i==length(ICx)
        plot(var.v(1,end-13000:end), var.v(2, end-13000:end), LineWidth=1.5, Color='#13ed43')
    end
end
for i = 1:length(ICxb)
    filename = sprintf('../Data/SingHopf_b5_%d', i);
    load(filename)
    plot(var.v(1,:), var.v(2,:), 'LineWidth',1.5, 'Color','#2580cf')
end
scatter([0,-2/3], [0, 4/27], 'filled','o', 'MarkerFaceColor','#000000')
plot(x_fp, y_fp, 'ko', ...
    'MarkerFaceColor','r', ...
    'MarkerEdgeColor','r', ...
    'MarkerSize',6, 'LineWidth',2)
xlim([-1.2, 0.6])
ylim([-0.1, 0.5])
% vertical line x = 0
hX0 = plot([0 0], ylim, 'k', 'LineWidth', 1);
% horizontal line y = 0
hY0 = plot(xlim, [0 0], 'k', 'LineWidth', 1);
% push them behind everything
uistack(hX0,'bottom')
uistack(hY0,'bottom')
grid on
set(gca,'Layer','bottom')
% Zoom box on main axes
rectangle(gca, ...
    'Position',[x_fp-dx, y_fp-dy, 2*dx, 2*dy], ...
    'EdgeColor','k', 'LineWidth',0.9)

% ===================== Inset =====================
ax_main = gca;
ax_main.TickDir = 'out';
ax_in = axes('Position',[0.2 0.63 0.3 0.27]);
box on
hold(ax_in,'on')

copyobj(allchild(ax_main), ax_in)

xlim(ax_in,[x_fp-dx x_fp+dx])
ylim(ax_in,[y_fp-dy y_fp+dy])

set(ax_in, ...
    'FontSize',8, ...
    'LineWidth',0.8, ...
    'TickDir','in', ...
    'XMinorTick','off', ...
    'YMinorTick','off',...
    'LooseInset', max(get(ax_in,'TightInset'), 0.01))

ax_in.XTick = linspace(x_fp-dx, x_fp+dx, 3);
ax_in.YTick = linspace(y_fp-dy, y_fp+dy, 3);
hold off

% ===================== Save =====================
savefig([Ffolder 'SingHopfpp5.fig'])
exportgraphics(gcf, [Ffolder 'SingHopfpp5.png'], 'ContentType','vector')
