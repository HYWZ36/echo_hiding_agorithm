function resample_attack(resample_fr)

[m, fs] = audioread('hide_no_noise.wav');
s_fs = fs;
m = m';
m = resample(m,resample_fr,fs);
audiowrite('hide_resamplemid.wav', m, resample_fr);
[n, fs] = audioread('hide_resamplemid.wav');
n = n';
n = resample(n,s_fs,fs);
audiowrite('hide.wav', n, s_fs);