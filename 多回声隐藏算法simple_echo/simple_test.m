clear all;
close all;
clc;


atten = 0.8;%attenuation
D00 = 8;
D01 = 12;
D10 = 10;
D11 = 20;
FRAG = 1024;
msg = 'abcdefghijklmnopqrstuvwxyz0123456789';

[bits, s] = simple_param_code(D00, D01,D10,D11, FRAG, atten, msg);
simple_param_decode(D00, D01,D10,D11, FRAG, msg, bits);

movefile('hide.wav', 'hide_no_noise.wav', 'f');
passchannel(25, 'hide_no_noise.wav', 'hide.wav');%25
simple_param_decode(D00, D01,D10,D11, FRAG, msg, bits);

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
simple_param_decode(D00, D01,D10,D11, FRAG, msg, bits);

