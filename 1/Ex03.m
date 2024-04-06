t = 0:0.001:1;
f1 = 1;
f2 = 3;
tau = 0.1;

% original signals
x1 = sin(2*pi*f1*t);
x2 = sin(2*pi*f2*t);

% time delayed signals
y1 = sin(2*pi*f1*(t-tau));
y2 = sin(2*pi*f2*(t-tau));

% phase shifted signals
phi1 = -2*pi*f1*tau;
phi2 = -2*pi*f2*tau;
z1 = sin(2*pi*f1*t + phi1);
z2 = sin(2*pi*f2*t + phi2);

% plot for sine 1
subplot(2,1,1);
plot(t, x1, 'b', 'LineWidth', 2); hold on;
plot(t, y1, 'r:', 'LineWidth', 2); 
plot(t, z1, 'g--', 'LineWidth', 2);
legend('Original', 'Time Delayed', 'Phase Shifted');
title('Sine 1');

% plot for sine 2
subplot(2,1,2); 
plot(t, x2, 'b', 'LineWidth', 2); hold on;
plot(t, y2, 'r:', 'LineWidth', 2); 
plot(t, z2, 'g--', 'LineWidth', 2);
legend('Original', 'Time Delayed', 'Phase Shifted');
title('Sine 2');