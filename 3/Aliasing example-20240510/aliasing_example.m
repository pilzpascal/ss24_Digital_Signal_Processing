% ALIASING OF SINE TONES
% ----------------------
% This script shows the Aliasing-effect for sine tones. Two sine waves are
% genereated and sampled at two different sampling frequencies. Remember
% that the frequency of a sine tone has to be less than fs/2 to avoid
% aliasing.
% The "analog" and sampled sine tones are plotted and can be additionally
% outputed to the soundcard of the computer.

close all; clear; clc

fs_analog = 192000; % sampling frequency of the simulated analog signal

% --- EDIT HERE --------
fs1 = 8000;         % higher sampling frequency of the sampled signals
fs2 = 4000;         % lower sampling frequency of the sampled signals
f1 = 4500;          % fundamental frequency of sine one
f2 = 500;           % fundamental frequency of sine two

T_audio = 3;       % duration [s] for the audio output
T_plot = 5e-3;     % duration [s] for visualization
% ----------------------

% time and sample vectors
ta = 0:1/fs_analog:T_audio;
td1 = 0:1/fs1:T_audio;
td2 = 0:1/fs2:T_audio;
na = 0:length(ta)-1;
n1 = 0:length(td1)-1;
n2 = 0:length(td2)-1;

A1 = 0.05;
A2 = 0.05;

% generate simulated analog signals
x1a = A1*sin(2*pi*f1/fs_analog*na);
x2a = A1*sin(2*pi*f2/fs_analog*na);  % cos

% generate sampled signals for fs1
x1td1 =  A1*sin(2*pi*f1/fs1*n1);
y1td1 = -A1*sin(2*pi*3500/fs1*n1);
x2td1 =  A1*sin(2*pi*f2/fs1*n1);     % cos

% generate sampled signals for fs2
x1td2 = A1*sin(2*pi*f1/fs2*n2);
x2td2 = A1*sin(2*pi*f2/fs2*n2);     % cos

% Plot results
% -------------------------------------------------------------------------------------------------
figure
subplot(221)
plot(ta,x1a,'Linewidth', 1.5)
hold on
stem(td1,x1td1,'Linewidth', 2)
stem(td1,y1td1,'g.','Linewidth', 0.5,'MarkerSize',2)
set(gca,'xlim',[0 T_plot])
xlabel('Time (s)'); ylabel('Amplitude'); title(sprintf('%d Hz @ fs = %d Hz', f1, fs1))
legend('Analogsignal', 'Abgetastets Signal', 'Location', 'BestOutside', 'Orientation', 'horizontal')

subplot(223)
plot(ta,x2a,'Linewidth', 1.5)
hold on
stem(td1,x2td1,'Linewidth', 2)
set(gca,'xlim',[0 T_plot])
xlabel('Time (s)'); ylabel('Amplitude'); title(sprintf('%d Hz @ fs = %d Hz', f2, fs1))
legend('Analogsignal', 'Abgetastets Signal', 'Location', 'BestOutside', 'Orientation', 'horizontal')

subplot(222)
plot(ta,x1a,'Linewidth', 1.5)
hold on
stem(td2,x1td2,'Linewidth', 2)
set(gca,'xlim',[0 T_plot])
xlabel('Time (s)'); ylabel('Amplitude'); title(sprintf('%d Hz @ fs = %d Hz', f1, fs2))
legend('Analogsignal', 'Abgetastets Signal', 'Location', 'BestOutside', 'Orientation', 'horizontal')

subplot(224)
plot(ta,x2a,'Linewidth', 1.5)
hold on
stem(td2,x2td2,'Linewidth', 2)
set(gca,'xlim',[0 T_plot])
xlabel('Time (s)'); ylabel('Amplitude'); title(sprintf('%d Hz @ fs = %d Hz', f2, fs2))
legend('Analogsignal', 'Abgetastets Signal', 'Location', 'BestOutside', 'Orientation', 'horizontal')
% -------------------------------------------------------------------------------------------------

% Output signals to the soundcard - please uncomment and listen to the
% single sounds one after the other 
% -------------------------------
sound(x1a,fs_analog)   %4500 @fs_analog
sound(x1td1,fs1)       %4500 sampled at 8000 Hz --> Aliasing!
sound(y1td1,fs1)       %3500Hz sampled at 8000 Hz leads to the same tone as 4500 @8000Hz
sound(x1td2,fs2)       %4500 sampled at 4000 Hz leads to 500 Hz sinewave
% 
sound(x2a,fs_analog)   %same sound as 4500 @ 4000, but x2a has true frequency at 500Hz
sound(x2td1,fs1)       %500 Hz sampled at 8000Hz --> no error
sound(x2td2,fs2)       %500 Hz sampled at 4000Hz --> no error
% -------------------------------

%% Aliasing of complex sound signals

close all; clear; clc

% --- EDIT HERE --------
file = 'Sample_BeeMoved_48kHz16bit.m4a';  % 
% ----------------------

fs_new = 8000;
fs_high = 48000;
ratio = fs_high/fs_new;

[audio_orig, fs] = audioread(file); % import soundfile into Matlab
audio = audio_orig(1:4.8*fs,:);     % the length of all soundfiles is limited to 4.8 seconds.

audio_48kHz = resample(audio, fs_high, fs); % all input files are first resmapled to 48kHz

audio_downsampled = resample(audio_48kHz,fs_new,fs_high); % downsampling with anti-aliasing filter
audio_downsampled_48kHz = resample(audio_downsampled,fs_high,fs_new); % upsample to 48kHz again (for comparison later)

audio_downsampled_alias = audio_48kHz(1:(fs_high/fs_new):end,:); % downsampling without anti-aliasing filter

% Plot spectrograms
% -------------------------------------------------------------------------------------------------
figure
subplot(221)
spectro_DSV(audio_48kHz(:,1), fs_high, 0, fs_new/2, [], sprintf('Original Spectrum @ fs = %d Hz', fs_high)) % plot until fs_high/2 instead of fs_new/2 to see the wohle frequency content of the sound
subplot(222)
spectro_DSV(audio_downsampled(:,1), fs_new, 0, fs_new/2, ratio, sprintf('Downsampled Spectrum @ fs = %d Hz', fs_new))
subplot(223)
spectro_DSV(audio_downsampled_alias(:,1), fs_new, 0, fs_new/2, ratio, sprintf('Downsampled Spectrum with Aliasing @ fs = %d Hz', fs_new))
subplot(224)
spectro_DSV(audio_downsampled_alias(:,1)-audio_downsampled(:,1), fs_new, 0, fs_new/2, ratio, sprintf('Aliasing Error @ fs = %d Hz', fs_new))
% -------------------------------------------------------------------------------------------------

% Output signals to the soundcard - please uncomment and listen to the
% single sounds one after the other 
% -------------------------------
% sound(audio_48kHz, fs_high);                                  % original soundfile
% sound(audio_downsampled, fs_new);                             % downsampled without aliasing
% sound(audio_downsampled_alias, fs_new);                       % downsampled with aliasing
% 
% sound(audio_48kHz-audio_downsampled_48kHz, fs_high);          % the upper frequency part of the original soundfile that can cause aliasing
% sound(audio_downsampled_alias-audio_downsampled, fs_new);     % Aliasing error
% -------------------------------
