function spectro_DSV(input_wav, Fs, fmin, fmax, ratio, caption)

if isempty(ratio)
    ratio = 1;
    input_wav = input_wav/12;
end
    
spectro(input_wav,4096,Fs,round(2048/ratio),90);
caxis([-60 20]);
set(gca,'ylim',[fmin fmax],'yscale','lin');
title(caption)

function varargout = spectro(x,N,fs,L,overlap,wintype,method,dims)
%SPECTRO Function to generate a spectrogram
%   By Danny Nguyen - ECE 6255 - Spring 2005
%   x: Data to plot
%   N: Length of FFT to be used
%   fs: Sampling frequency of input
%   L: Length of STFT to be used
%   overlap: Percentage of overlap for the STFT's (between 0 and 99)
%   wintype: Window type to be used
%   dims: 2 for 2D, or 3 for 3D
%   method: 'std' for standard spectrogram
%           'acm' for autocorrelation method
%           'cov' for covariance method
%           'burg' for Burg method (lattice)
%           'cep' for cepstrogram
%           'ltl' for low-time liftered spectrogram
%           'htl' for high-time liftered spectrogram

% Set defaults if undefined
if nargin < 2 | isempty(N), N = 512; end            % 512 Length FFT
if nargin < 3 | isempty(fs), fs = 16000; end        % 16kHz sampling rate
if nargin < 4 | isempty(L), L = 40; end             % Wideband STFT
if nargin < 5 | isempty(overlap), overlap = 90; end % 90% overlap
if nargin < 6 | isempty(wintype), wintype = @hamming; end
if nargin < 7 | isempty(method), method = 'std'; end    % Standard mode
if nargin < 8 | isempty(dims), dims = 2; end        % 2-D Plot

% Initializations
win = window(wintype,L);            % Set up window
inc = floor(L*(1-overlap/100));     % Determine shift distance for window
x = x(:);                           % Arranges data into a vertical column
j = 1;                              % Initialize counter
tend = floor((length(x)-L)/inc)+1;  % End time for sample
p = 12;                             % Number of poles for filter
spec=zeros(N,tend);                 % Initialize matrix for more speed

% Calculate spectrogram matrix
switch method
    
    % Regular spectrogram
    case 'std'
        spec=zeros(L,tend);         % Initialize matrix for more speed
        for i=1:inc:length(x)-L
            spec(:,j)=x(i:i+L-1).*win;  % Copy windowed values to matrix
            j=j+1;
        end
        spec=fft(spec,N,1);         % Perform FFT on samples
        
        % Autocorrelation method
    case 'acm'
        for i=1:inc:length(x)-L
            [a,err]=acm(x(i:i+L-1).*win,p);
            spec(:,j)=sqrt(err)./fft(a,N,1);
            j=j+1;
        end
        
        % Covariance method
    case 'cov'
        for i=1:inc:length(x)-L
            [a,err]=covm(x(i:i+L-1).*win,p);
            spec(:,j)=sqrt(err)./fft(a,N,1);
            j=j+1;
        end
        
        % Burg method
    case 'burg'
        for i=1:inc:length(x)-L
            [g,err]=burg(x(i:i+L-1).*win,p);
            a=gtoa(g);
            spec(:,j)=sqrt(err(p))./fft(a,N,1);
            j=j+1;
        end
        
        % Spectrogram with low-time liftering
    case 'ltl'
        n0 = 30;                            % Lifter length
        for i=1:inc:length(x)-L
            temp=x(i:i+L-1).*win;           % Window sample
            temp=ifft(log(fft(temp,N)));    % Convert to cepstrum domain
            temp(n0+1:N-n0+1)=0;            % Low-time lifter
            spec(:,j)=exp(fft(temp));       % Convert to freq. domain
            j=j+1;
        end
        
        % Spectrogram with high-time liftering
    case 'htl'
        n0 = 30;                            % Lifter length
        for i=1:inc:length(x)-L
            temp=x(i:i+L-1).*win;           % Window sample
            temp=ifft(log(fft(temp,N)));    % Convert to cepstrum domain
            temp(1:n0)=0;                   % High-time lifter (left end)
            temp(N-n0+1:N)=0;               % High-time lifter (right end)
            spec(:,j)=exp(fft(temp));       % Convert to freq. domain
            j=j+1;
        end
        
        % Real Cepstrogram
    case 'cep'
        spec=zeros(L,tend);         % Initialize matrix for more speed
        for i=1:inc:length(x)-L
            spec(:,j)=x(i:i+L-1).*win;      % Copy windowed values to matrix
            j=j+1;
        end
        spec=ifft(log(abs(fft(spec,N,1))));
        % Remove symmetry
        spec=spec(1:floor(size(spec,1)/2)+1,:);
        % Display matrix
        taxis=0:length(x)/fs/(j-2):length(x)/fs;
        warning off MATLAB:log:logOfZero
        faxis=0:N/2;
        if dims == 2
            imagesc(taxis,[],db(spec));
        else
            mesh(taxis,faxis,db(spec));
            view(5,60)                  % Set view
            zlabel('Magnitude (dB)')
        end
        warning on MATLAB:log:logOfZero
        % Set colors and labels
        axis xy;colormap(jet)
        xlabel('Time (s)'),ylabel('Quefrency')
        % Allows the user to save the spectrogram data matrix
        if nargout==1
            varargout(1)={spec};
        end
        return;
        
    otherwise
        error('Spectrogram method not recoginzed')
end

% Remove symmetry due to FFT
% spec=spec(1:floor(size(spec,1)/2)+1,:);
spec=spec(1:floor(size(spec,1)/2)+1,1:end-1);

% Display matrix
taxis=0:length(x)/fs/(j-2):(length(x)-1)/fs;
faxis=0:fs/N:fs/2;

warning off MATLAB:log:logOfZero
if dims == 2
%     imagesc(taxis,faxis,db(spec));
    surf(taxis,faxis,db(spec));
    shading flat;
else
    mesh(taxis,faxis,db(spec));
    view(5,60)                  % Set view
    zlabel('Magnitude (dB)')
end
warning on MATLAB:log:logOfZero

% Set colors and labels
view(2);axis tight;colormap(jet)
xlabel('Time (s)'), ylabel('Frequency (Hz)')

% Allows the user to save the spectrogram data matrix
% if nargout==1
%     varargout(1)={h};
% end