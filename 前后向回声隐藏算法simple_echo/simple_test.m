clear all;
close all;
clc;


atten = 0.95;%attenuation
D0 = 8;
D1 = 12;
FRAG = 1024;
msg = 'abcdefghijklmnopqrstuvwxyz0123456789';

[bits, s] = simple_param_code(D0, D1, FRAG, atten, msg);
simple_param_decode(D0, D1, FRAG, msg, bits);

movefile('hide.wav', 'hide_no_noise.wav', 'f');
passchannel(25, 'hide_no_noise.wav', 'hide.wav');%25
simple_param_decode(D0, D1, FRAG, msg, bits);

%resample
[m, fs] = audioread('hide_no_noise.wav');
s_fs = fs;
m = m';
m = resample(m,6000,fs);
audiowrite('hide_resamplemid.wav', m, 6000);
[n, fs] = audioread('hide_resamplemid.wav');
n = n';
n = resample(n,s_fs,fs);
audiowrite('hide.wav', n, s_fs);
fprintf('resample-attack\n');
simple_param_decode(D0, D1, FRAG, msg, bits);
 

