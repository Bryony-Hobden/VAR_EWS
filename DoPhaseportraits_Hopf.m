clear all
close all
% Run to produce phase portraits for the subcritical Hopf system
%% Hopf fig 1
load('../Data/Hopf_1_traj');

Dfolder = '../Data/';
Ffolder = '../Figures/';

vx_traj = var.v(1,:);
vy_traj = var.v(2,:);

%check consistent with Parameters_ppHopf.m
ICx = [1.5 1.25 -1.5 -1 -1.5 -1.25 1.5 1 -0.1 0.3];
ICy = [1 1.5 1.25 1.5 -1 -1.5 -1.25 -1.5 0.1 0.3];

figure()
set(gcf, 'Position', [10 10 700 600])
hold on
%quiver(X, Y, U, V, 'Color','#25b6cf', 'LineWidth',1.1)
xlabel('x')
ylabel('y')
scatter(0, 0, 100, 'filled' ,'o', MarkerFaceColor='r')
for i=1:length(ICx)
    filename = sprintf('../Data/Hopf_1_%d', i);
    load(filename);
    plot(var.v(1,:), var.v(2, :), LineWidth=1.5, Color='#2580cf')
    scatter(par.v0(1), par.v0(2),50, 'filled' ,'o', MarkerFaceColor='#2580cf')
end
plot(var.v(1,end-1000:end), var.v(2, end-1000:end), LineWidth=2.5, Color='#13ed43')
xlim([-1.5, 1.5])
ylim([-1.5, 1.5])
hX0 = plot([0 0], ylim, 'k', 'LineWidth', 1);
% horizontal line y = 0
hY0 = plot(xlim, [0 0], 'k', 'LineWidth', 1);
% push them behind everything
uistack(hX0,'bottom')
uistack(hY0,'bottom')
%set grid behind
grid on
set(gca,'Layer','bottom')
hold off
gcf()
savefig([Ffolder 'Hopfpp1' '.fig']);
exportgraphics(gcf(), [Ffolder 'Hopfpp1' '.png']);

%% Hopf fig 2
load('../Data/Hopf_2_traj');

Dfolder = '../Data/';
Ffolder = '../Figures/';

vx_traj = var.v(1,:);
vy_traj = var.v(2,:);

r_inner = sqrt((1-sqrt(1-4*par.lambda_0))/2);
r_outer = sqrt((1+sqrt(1-4*par.lambda_0))/2);
th = 0:pi/50:2*pi;

x_inner = r_inner * cos(th);
y_inner = r_inner * sin(th);

x_outer = r_outer * cos(th);
y_outer = r_outer * sin(th);

%check consistent with Parameters_ppHopf.m
ICx = [1.5 1.25 -1.5 -1 -1.5 -1.25 1.5 1 -0.1 0.3 -0.5];
ICy = [1 1.5 1.25 1.5 -1 -1.5 -1.25 -1.5 0.1 0.3 0];

figure()
set(gcf, 'Position', [10 10 700 600])
hold on
xlabel('x')
ylabel('y')
for i=1:length(ICx)
    filename = sprintf('../Data/Hopf_2_%d', i);
    load(filename);
    plot(var.v(1,:), var.v(2, :), LineWidth=1.5, Color='#2580cf')
    scatter(par.v0(1), par.v0(2),50, 'filled' ,'o', MarkerFaceColor='#2580cf')
end
plot(x_inner, y_inner, LineStyle="--", LineWidth=2.5, Color='r')
plot(x_outer, y_outer, LineWidth=2.5, Color='#13ed43')
scatter(0, 0, 75, 'filled' ,'o', MarkerFaceColor='#13ed43')
xlim([-1.5, 1.5])
ylim([-1.5, 1.5])
hX0 = plot([0 0], ylim, 'k', 'LineWidth', 1);
% horizontal line y = 0
hY0 = plot(xlim, [0 0], 'k', 'LineWidth', 1);
% push them behind everything
uistack(hX0,'bottom')
uistack(hY0,'bottom')
%set grid behind
grid on
set(gca,'Layer','bottom')
hold off
gcf()
savefig([Ffolder 'Hopfpp2' '.fig']);
exportgraphics(gcf(), [Ffolder 'Hopfpp2' '.png']);

%% Hopf fig 3
load('../Data/Hopf_3_traj');

Dfolder = '../Data/';
Ffolder = '../Figures/';

vx_traj = var.v(1,:);
vy_traj = var.v(2,:);

%check consistent with Parameters_ppHopf.m
ICx = [1.5 1.25 -1.5 -1 -1.5 -1.25 1.5 1 -0.1 0.3];
ICy = [1 1.5 1.25 1.5 -1 -1.5 -1.25 -1.5 0.1 0.3];

figure()
set(gcf, 'Position', [10 10 700 600])
hold on
xlabel('x')
ylabel('y')
scatter(0, 0,100, 'filled' ,'o', MarkerFaceColor='red')
for i=1:length(ICx)
    filename = sprintf('../Data/Hopf_3_%d', i);
    load(filename);
    plot(var.v(1,:), var.v(2, :), LineWidth=1.5, Color='#2580cf')
    scatter(par.v0(1), par.v0(2),50, 'filled' ,'o', MarkerFaceColor='#2580cf')
end
scatter(0, 0,100, 'filled' ,'o', MarkerFaceColor='#13ed43')
xlim([-1.5, 1.5])
ylim([-1.5, 1.5])
hX0 = plot([0 0], ylim, 'k', 'LineWidth', 1);
% horizontal line y = 0
hY0 = plot(xlim, [0 0], 'k', 'LineWidth', 1);
% push them behind everything
uistack(hX0,'bottom')
uistack(hY0,'bottom')
%set grid behind
grid on
set(gca,'Layer','bottom')
hold off
gcf()
savefig([Ffolder 'Hopfpp3' '.fig']);
exportgraphics(gcf(), [Ffolder 'Hopfpp3' '.png']);