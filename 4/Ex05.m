clear
close all
clc

N = 128;
n = 0:N-1;
w1 = 2 * pi * 0.1;
w2 = 2 * pi * 0.15;

x = cos(w1 * n) + cos(w2 * n);

% (a) ----------------------------
X = fft(x);
magnitude_X = abs(X);
figure;
stem(magnitude_X);
title('Magnitude Spectrum of x');
xlabel('Frequency');
ylabel('Magnitude');

% (b) ----------------------------
hamming_window = hamming(N);

y = x .* hamming_window';

Y = fft(y);
magnitude_Y = abs(Y);
figure;
stem(magnitude_Y);
title('Magnitude Spectrum of y');
xlabel('Frequency');
ylabel('Magnitude');