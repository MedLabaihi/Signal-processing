% Load the scaling factor
load('audios/scale_factor.mat', 'scale_factor');

% Read and reverse the scaling
[c1_scaled, fs] = audioread('audios/audio_Enc.wav');
c1 = c1_scaled * scale_factor;

% Check if audio data is read correctly
if isempty(c1)
    error('Encrypted audio file is empty or not read correctly.');
end

% Preallocate the output array for better performance
m10 = zeros(size(c1));

% Decrypt the audio samples using modular exponentiation and CRT

for i = 1:length(c1)
    m1 = modExp(c1(i), dp, p);
    m2 = modExp(c1(i), dq, q);
    h = mod(qinv * (m1 - m2), p);
    m10(i) = m2 + h * q;
end
% Reverse the scaling and shifting applied during encryption
m20 = (m10 - 50000) / 100000;
% Check if decrypted data is reasonable
if isempty(m20) || all(isnan(m20)) || all(isinf(m20))
    error('Decrypted audio data is empty or contains invalid values.');
end

% Plot the encrypted and decrypted signals
figure;

subplot(2,1,1);
plot(c1);
title('Encrypted Signal');
xlabel('Sample Index');
ylabel('Amplitude');

subplot(2,1,2);
plot(m20);
title('Decrypted Signal');
xlabel('Sample Index');
ylabel('Amplitude');


% Save the plot as an image file
saveas(gcf, 'plots/decrypted_audio_plot.png');

% Save decrypted audio
audiowrite('audios/audio_Dec.wav', m20, fs);