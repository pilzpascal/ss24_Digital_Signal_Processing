clear
close all
clc

[signal, fs] = audioread('dtmf.wav');
block_size = 256;
overlap_factor = 2;

window = hamming(block_size);

stft_mtx = [];
for i = 1:block_size/overlap_factor:length(signal)
    if i+block_size-1 <= length(signal)
        block = signal(i:i+block_size-1);
    else
        block = [signal(i:end); zeros(block_size - length(signal(i:end)), 1)];
    end

    windowed_block = block %.* window;
    
    ftb = fft(windowed_block);
    stft_mtx = [stft_mtx, ftb];
end

f_stft = (0:block_size-1) * fs / block_size;
t_stft = (0:size(stft_mtx, 2)-1) * block_size / overlap_factor / fs;

figure;
surface(t_stft, f_stft, abs(stft_mtx));
xlabel('Time (s)');
ylabel('Frequency (Hz)');
zlabel('Magnitude');
%title('STFT Magnitude Diagram');
title('STFT Magnitude Diagram without Hamming Window');
colorbar;

ylim([0 2000]);