[c1, fs] = audioread('audios/audio_Enc.wav');
figure;
plot(c1);
title('Encrypted Signal');
xlabel('Sample Index');
ylabel('Amplitude');