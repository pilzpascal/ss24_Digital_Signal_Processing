close all; clear; clc;

load('Filter_coefficients.mat');

n = 0:1:3*length(b1)-1;
x = zeros(size(n));
for i = 1:4
    x = x + (1/(2*i-1)) * sin(2*pi*0.005*(2*i-1)*n);
end

y_fir = filter(b1, a1, x);
y_iir = filter(b2, a2, x);

subplot(3,1,1);
plot(n, x);
title('Original Signal x[n]');
xlabel('n');
ylabel('Amplitude');

subplot(3,1,2);
plot(n, y_fir);
title('Filtered Signal (FIR)');
xlabel('n');
ylabel('Amplitude');

subplot(3,1,3);
plot(n, y_iir);
title('Filtered Signal (IIR)');
xlabel('n');
ylabel('Amplitude');