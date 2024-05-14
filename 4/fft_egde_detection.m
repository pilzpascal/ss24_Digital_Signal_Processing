clear; close all; clc;

img = imread('pavian.png'); % Choose any picture you like here
img = rgb2gray(img);

%% Display image
figure; subplot(131);
imshow(img);
title('Ausgangsbild');

%% FFT
fft2d = fft2(img);

% Display the FFT image.
subplot(132);
imshow(log(fftshift(abs(fft2d))), []);
title('2D-FFT');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
%Your turn


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% IFFT to obtain filtered image
img_filtered = ifft2(fft2d);
subplot(133);
imshow(real(img_filtered), []);
title('Gefiltertes Ausgangssignal');
