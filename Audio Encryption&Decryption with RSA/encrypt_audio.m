% Read the original audio file
[x1, fs] = audioread('audios/audio_Original.wav');  % Read audio file
x = x1(:, 1);  % Extract first channel (mono)

% Scale and shift audio data
x2 = fix(x * 100000) + 50000;

% Preallocate the output array for better performance
c1 = zeros(size(x2));

% Encryption parameters (e and n should be set appropriately)
e = 499; % Example value; adjust as necessary
n = 487 * 509; % Example modulus; adjust according to your p and q values

% Encrypt the audio samples using modular exponentiation
for i = 1:length(x2)
    c1(i) = modExp(x2(i), e, n);
end

% Plot original and encrypted signals
figure;

subplot(2,1,1);
plot(x);
title('Original Signal');
xlabel('Sample Index');
ylabel('Amplitude');

subplot(2,1,2);
plot(c1);
title('Encrypted Signal');
xlabel('Sample Index');
ylabel('Amplitude');

% Save the plot as an image file
saveas(gcf, 'plots/encrypted_audio_plot.png');


% Scale the encrypted audio to the range [-1, 1]
scale_factor = max(abs(c1));
c1_scaled = c1 / scale_factor;

% Save the scaling factor to a file
save('audios/scale_factor.mat', 'scale_factor');

% Save the scaled encrypted audio
audiowrite('audios/audio_Enc.wav', c1_scaled, fs);


