f0 = 1;
hat_X = 1;
f = -3:0.01:3;

% We need a Function to approximate Dirac delta
delta = @(f, f0) abs(f - f0) < 0.01;

% Fourier Transform of cosine wave
X_f = hat_X/2 * (delta(f, f0) + delta(f, -f0));

figure;
plot(f, real(X_f), 'b', 'LineWidth', 2); hold on;
plot(f, imag(X_f), 'r', 'LineWidth', 2); hold off;
xlabel('Frequency (f)');
ylabel('X(f)');
legend('Real part', 'Imaginary part');
title('Fourier Transform of Cosine Wave');