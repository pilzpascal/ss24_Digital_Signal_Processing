%% b)
close all; clear; clc; hold on; grid on; pbaspect([1 1 1]);

% x and y axis
xline(0, 'Color', 'k', 'LineWidth', 0.5);
yline(0, 'Color', 'k', 'LineWidth', 0.5);

% poles
plot(0, 0, 'x', Color='#0072BD', LineWidth=1);
plot(0.75, 0.25, 'x', Color='#0072BD', LineWidth=1);
plot(0.75, -0.25, 'x', Color='#0072BD', LineWidth=1);

% zeros
plot(-1, 0, 'o', Color='#0072BD', LineWidth=1);
plot(0, 1, 'o', Color='#0072BD', LineWidth=1);
plot(0, -1, 'o', Color='#0072BD', LineWidth=1);

% unit circle
plot(cos(linspace(0, 2*pi, 1000)), sin(linspace(0, 2*pi, 1000)));


axis([-1.1, 1.1, -1.1, 1.1])
xlabel('Real Part');
ylabel('Imaginery Part');
title('Pole-zero Diagram');
legend('', '', 'poles', '', '', 'zeros', '', '');
