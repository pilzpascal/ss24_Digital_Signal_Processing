%% d)
close all; clear; clc; hold on; grid on; pbaspect([1 1 1]);

% x and y axis
xline(0, 'Color', 'k', 'LineWidth', 0.5);
yline(0, 'Color', 'k', 'LineWidth', 0.5);

% poles and zeros
plot(- 1 / 30, sqrt(8980) / 150, 'x', Color='#0072BD', LineWidth=1);
plot(- 1 / 30, - sqrt(8980) / 150, 'x', Color='#0072BD', LineWidth=1);
plot(0, 0, 'o', Color='#0072BD', LineWidth=1);

% unit circle
plot(cos(linspace(0, 2*pi, 1000)), sin(linspace(0, 2*pi, 1000)));

% region of convergence
t = linspace(0, 2*pi, 1000);
r = abs(-1/30 + 1j * sqrt(8980)/150);
pgon = polyshape({[-1.2 -1.2 1.2 1.2], r*cos(t)}, ...
                 {[1.2 -1.2 -1.2 1.2], r*sin(t)});
plot(pgon)

axis([-1.1, 1.1, -1.1, 1.1])
xlabel('Real Part');
ylabel('Imaginery Part');
title('Pole-zero Diagram');
legend('', '', 'poles', '', 'zeros', '', 'region of convergence');
