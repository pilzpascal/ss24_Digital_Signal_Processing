clear
close all
clc

n = -15:15;
Omega = 5 * pi;
w = linspace(-Omega, Omega, 1000);

X = dtft(@x, n, w);

% magnitude response
subplot(2, 1, 1);
plot(w, abs(X));
title('Magnitude Response');
xline((-floor(Omega / pi):floor(Omega / pi)) * pi);
xlabel('\Omega');
ylabel('|X(e^{j\Omega})|');

% phase response
subplot(2, 1, 2);
plot(w, angle(X));
title('Phase Response');
xlabel('\Omega');
ylabel('Phase of X(e^{j\Omega})');

sgtitle('Magnitude and Phase Response of X(e^{j\Omega}) for -\pi \leq \Omega \leq \pi');



function y = u(n)
    y = 1.*(n>=0);
end

function y = x(n)
    y = ((0.8).^abs(n)) .* (u(n+10) - u(n-11));
end

function X = dtft(x, n, w)
    % DTFT Computes Discrete-time Fourier transform
    % @param    x: finite duration sequence over n
    % @param    n: sample position vector
    % @param    w: frquency location vector
    % @return   X: DTFT values computed at w frequencies

    x_vals = x(n);
    X = x_vals * exp(-1j .* n' * w);
end
