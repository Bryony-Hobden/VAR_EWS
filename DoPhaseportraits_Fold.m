clear all
close all
% Run the script to produce the phase portraits for the fold on the slow
% manifold system
%% Fold fig 1
load('../Data/Fold_1_traj');

Dfolder = '../Data/';
Ffolder = '../Figures/';

y= linspace(-1.5, 1, 10000);
f = @(y)((y.^2).*(1+y));
x = f(y);

vx_traj = var.v(1,:);
vy_traj = var.v(2,:);

%check consistent with Parameters_ppFold.m
ICx = [0.2 0.2 -0.2 0.2 -0.2 -0.2 -0.2];
ICy = [0.3 -0.45 -0.35 -1.1 -0.1 -0.6 -1.1]; 

p = [1 1 0 -0.1];
r = roots(p);

figure()
set(gca,'Layer','top')
hold on
plot(x, y, Color='black', LineWidth=2.5)
xlabel('x')
ylabel('y')
for i=1:length(ICx)
    filename = sprintf('../Data/Fold_1_%d', i);
    load(filename);
    plot(var.v(1,:), var.v(2, :), LineWidth=1.5, Color='#2580cf')
    scatter(par.v0(1), par.v0(2), 'filled' ,'o', MarkerFaceColor='#2580cf')
end
for n = 1:length(r)
    if abs(imag(r(n))) < 1e-10 % Check if real
        x_pos = par.lambda_0; % Use the variable for the vertical line
        y_pos = real(r(n));
        
        if n == 2
            s = scatter(x_pos, y_pos, 60, 'filled', 'MarkerFaceColor', 'r');
        else
            s = scatter(x_pos, y_pos, 60, 'filled', 'MarkerFaceColor', '#13ed43');
        end
        uistack(s, 'top'); % Force the point to the front layer
    end
end
yl = ylim;  % get limits later if needed
hVL = plot([par.lambda_0 par.lambda_0], [-2 2], ...
    'Color','#cf25b8','LineWidth',2.5);
uistack(hVL,'bottom')   % push vertical line behind everything
xlim([-0.2, 0.2])
ylim([-1.2, 0.4])
grid on
set(gca,'Layer','bottom')
% vertical line x = 0
hX0 = plot([0 0], ylim, 'k', 'LineWidth', 1);
% horizontal line y = 0
hY0 = plot(xlim, [0 0], 'k', 'LineWidth', 1);
% push them behind everything
uistack(hX0,'bottom')
uistack(hY0,'bottom')
hold off
gcf()
savefig([Ffolder 'Foldpp1' '.fig']);
exportgraphics(gcf(), [Ffolder 'Foldpp1' '.png']);

%% Fold fig 2
load('../Data/Fold_2_traj');

Dfolder = '../Data/';
Ffolder = '../Figures/';

y= linspace(-1.5, 1, 10000);
f = @(y)((y.^2).*(1+y));
x = f(y);

vx_traj = var.v(1,:);
vy_traj = var.v(2,:);


%check consistent with Parameters_ppFold.m
ICx = [0.2 0.2 -0.2 0.2 -0.2 -0.2 -0.2];
ICy = [0.3 -0.45 -0.35 -1.1 -0.1 -0.6 -1.1]; 


p = [1 1 0 0];
r = roots(p);

figure()
set(gca,'Layer','top')
hold on
plot(x, y, Color='black', LineWidth=2.5)
xlabel('x')
ylabel('y')
for i=1:length(ICx)
    filename = sprintf('../Data/Fold_2_%d', i);
    load(filename);
    plot(var.v(1,:), var.v(2, :), LineWidth=1.5, Color='#2580cf')
    scatter(par.v0(1), par.v0(2), 'filled' ,'o', MarkerFaceColor='#2580cf')
end
for n = 1:length(r)
    if abs(imag(r(n))) < 1e-10 % Check if real
        x_pos = par.lambda_0; % Use the variable for the vertical line
        y_pos = real(r(n));
        
        if n == 2
            s = scatter(x_pos, y_pos, 60, 'filled', 'MarkerFaceColor', '#cf25b8');
        else
            s = scatter(x_pos, y_pos, 60, 'filled', 'MarkerFaceColor', '#13ed43');
        end
        uistack(s, 'top'); % Force the point to the front layer
    end
end
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
xlim([-0.2, 0.2])
ylim([-1.2, 0.4])
grid on
set(gca,'Layer','bottom')
hold off
gcf()
savefig([Ffolder 'Foldpp2' '.fig']);
exportgraphics(gcf(), [Ffolder 'Foldpp2' '.png']);

%% Fold fig 3

load('../Data/Fold_3_traj');

Dfolder = '../Data/';
Ffolder = '../Figures/';

y= linspace(-1.5, 1, 10000);
f = @(y)((y.^2).*(1+y));
x = f(y);

vx_traj = var.v(1,:);
vy_traj = var.v(2,:);

%check consistent with Parameters_ppFold.m
ICx = [0.2 0.2 -0.2 0.2 -0.2 -0.2 -0.2];
ICy = [0.3 -0.45 -0.35 -1.1 -0.1 -0.6 -1.1]; 


p = [1 1 0 0.1];
r = roots(p);


figure()
set(gca,'Layer','top')
hold on
plot(x, y, Color='black', LineWidth=2.5)
xlabel('x')
ylabel('y')
for i=1:length(ICx)
    filename = sprintf('../Data/Fold_3_%d', i);
    load(filename);
    plot(var.v(1,:), var.v(2, :), LineWidth=1.5, Color='#2580cf')
    scatter(par.v0(1), par.v0(2), 'filled' ,'o', MarkerFaceColor='#2580cf')
end
for n = 1:length(r)
    if abs(imag(r(n))) < 1e-10 % Check if real
        x_pos = par.lambda_0; % Use the variable for the vertical line
        y_pos = real(r(n));
        
        if n == 2
            s = scatter(x_pos, y_pos, 60, 'filled', 'MarkerFaceColor', 'r');
        else
            s = scatter(x_pos, y_pos, 60, 'filled', 'MarkerFaceColor', '#13ed43');
        end
        uistack(s, 'top'); % Force the point to the front layer
    end
end
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
xlim([-0.2, 0.2])
ylim([-1.2, 0.4])
grid on
set(gca,'Layer','bottom')
xlim([-0.2, 0.2])
ylim([-1.2, 0.4])
hX0 = plot([0 0], ylim, 'k', 'LineWidth', 1);
% horizontal line y = 0
hY0 = plot(xlim, [0 0], 'k', 'LineWidth', 1);
% push them behind everything
uistack(hX0,'bottom')
uistack(hY0,'bottom')
hold off
gcf()
savefig([Ffolder 'Foldpp3' '.fig']);
exportgraphics(gcf(), [Ffolder 'Foldpp3' '.png']);
