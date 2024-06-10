clear
close all
clc

[signal, fs] = audioread('dtmf.wav');

N = length(signal);
f = (0:N-1)*(fs/N);
signal_fft = fft(signal);C

magnitude_spectrum = abs(signal_fft);

figure;
plot(f, magnitude_spectrum);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum of DTMF Signal');
xlim([0 fs/2]); % Limit the x-axis for vis up to nyquist frequency
