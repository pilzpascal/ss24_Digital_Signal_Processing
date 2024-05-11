%% a)
close all; clear; clc

hold on;

stem([-6, -4, 4, 6], [1, 1, -1, -1], 'color', 'black', LineWidth=1.5)

stem([0, 0], [-1.2, 1.2], Marker="none", Color=[.2 .2 .2])   % manually drawn grid

axis([-8, 8, -1.2, 1.2])
xticks([-6, -4, 0, 4, 6])
xticklabels(["-6", "-4", "0", "4", "6"])
yticks([-1, 0, 1])
yticklabels(["-1j", "0", "1j"])
xlabel('Frequency (kHz)');
ylabel('Amplitude');
title('Spectrum of analog signal');

%% b)
close all; clear; clc

subplot(2, 1, 1);
hold on;

stem([-16, -14], [-1, -1], LineWidth=1.5)
stem([-16, -14, -6, -4], [1, 1, -1, -1], LineWidth=1.5)
stem([-6, -4, 4, 6], [1, 1, -1, -1], LineWidth=1.5)
stem([4, 6, 14, 16], [1, 1, -1, -1], LineWidth=1.5)
stem([16, 14], [1, 1], LineWidth=1.5)

stem([-10, -10, 0, 0, 10, 10], [-1.2, 1.2, -1.2, 1.2, -1.2, 1.2], ...
    Marker="none", Color=[.2 .2 .2])  % manually drawn grid

legend(["shifted by $-2f_s$", "shifted by $-f_s$", ...
    "shifted by $0$", "shifted by $f_s$", "shifted by $2f_s$"])

axis([-18, 18, -1.2, 1.2])
xticks([-16, -14, -10, -6, -4, 0, 4, 6, 10, 14, 16])
xticklabels( ["-16", "-14", "$-f_s(=-10)$", "-6", "-4", ...
    "0", "4", "6", "$f_s(=10)$", "14", "16"])
yticks([-1, 0, 1])
yticklabels(["-1j", "0", "1j"])
ylabel('Amplitude');
xlabel('Frequency (kHz)');
title('Spectrum of analog signal with shifted versions');

subplot(2, 1, 2);
hold on;

stem([-16, -14, -6, -4, 4, 6, 14, 16], [0, 0, 0, 0, 0, 0, 0, 0], LineWidth=1.5)
stem([-10, -10, 0, 0, 10, 10], [-1.2, 1.2, -1.2, 1.2, -1.2, 1.2], ...
    Marker="none", Color=[.2 .2 .2])  % manually drawn grid

axis([-18, 18, -1.2, 1.2])
xticks([-16, -14, -10, -6, -4, 0, 4, 6, 10, 14, 16])
xticklabels( ["-16", "-14", "$-f_s(=-10)$", "-6", "-4", ...
    "0", "4", "6", "$f_s(=10)$", "14", "16"])
yticks([-1, 0, 1])
yticklabels(["-1j", "0", "1j"])
ylabel('Amplitude');
xlabel('Frequency (kHz)');
title('Result of adding all shifted versions');

set(groot,'defaultAxesTickLabelInterpreter','latex'); 
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

%% c)
close all; clear; clc; hold on;

f1 = 4e3;   % Frequency of the first sine wave in Hz
f2 = 6e3;   % Frequency of the second sine wave in Hz

f_analog = 1000e3; % "Sampling frequency" to emulate analog signal
t_analog = linspace(0, 0.002, (f_analog) * 0.002);
x_analog = sin(2 * pi * f1 * t_analog) + sin(2 * pi * f2 * t_analog);
plot(t_analog, x_analog)

f_sampled = 10e3;  % Sampling rate in Hz
t_sampled = linspace(0, 0.002, f_sampled * 0.002 + 1);
x_sampled = sin(2 * pi * f1 * t_sampled) + sin(2 * pi * f2 * t_sampled);
stem(t_sampled, x_sampled, LineWidth=1.5);

xticks(linspace(0, 0.002, 5))
xticklabels(linspace(0, 2, 5))
title("Analog Signal $x(t)$ vs. Sampled Signal $x[t]$", 'interpreter','latex')
legend(["Analog Signal $x(t)$", "Sampled Signal $x[t]$"])
xlabel("time [ms]")
