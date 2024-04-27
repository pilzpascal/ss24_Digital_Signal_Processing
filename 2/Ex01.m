clear
close all
clc 

% Discrete time vectors
n1 = -5:10;
n2 = 0:256;

% Define signals
x1 = -4 * (n1 == -3) + 4 * (n1 == 0) - (n1 == 3) + 2 * (n1 == 7);
x2 = exp(-0.31 * n1);
x3 = 3 * sin(2 * pi * 3.5/64 * n2);
x4 = -cos(9/64 * n2);

% Plot signals
figure;
subplot(2,2,1); stem(n1, x1); title('x_1[n]'); xlabel('n'); ylabel('Amplitude'); grid on;
subplot(2,2,2); stem(n1, x2); title('x_2[n]'); xlabel('n'); ylabel('Amplitude'); grid on;
subplot(2,2,3); plot(n2, x3); title('x_3[n]'); xlabel('n'); ylabel('Amplitude'); grid on;
subplot(2,2,4); plot(n2, x4); title('x_4[n]'); xlabel('n'); ylabel('Amplitude'); grid on;

% Calculate normalized angular frequency
Omega_x3 = 2 * pi * 3.5/64;
Omega_x4 = 9/64;

% Calculate fundamental period
T_x3 = 2*pi/Omega_x3;
T_x4 = 2*pi/Omega_x4;

% Define custom_power function
function P = custom_power(x)
    N = length(x);
    P = 1/N * sum(abs(x).^2);
end

% Calculate powers of all periodic signals
P_x3 = custom_power(x3(1:T_x3));
P_x4 = custom_power(x4(1:T_x4));

% Define energy function
function W = energy(x)
    W = sum(abs(x).^2);
end

% Calculate the energies for all these time-limited signals
W_x1 = energy(x1);
W_x2 = energy(x2);
W_x3 = energy(x3);
W_x4 = energy(x4);