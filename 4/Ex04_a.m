clear
close all
clc

[signal, fs] = audioread('dtmf.wav');
t = (0:length(signal)-1)/fs;

time_segment = t(1:0.3*fs);
signal_segment = signal(1:0.3*fs);

figure;
plot(time_segment, signal_segment);
xlabel('Time (s)');
ylabel('Amplitude');
title('300 ms Segment of DTMF Signal');