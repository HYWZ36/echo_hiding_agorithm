clear all;
close all;
clc;


atten = 0.7;%attenuation
D0 = 8;
D1 = 12;
FRAG = 1024;
flag = 0;
msg = 'abcdefghijklmnopqrstuvwxyz0123456789';

[bits, s] = simple_param_code(D0, D1, FRAG, atten, msg);
fprintf('no-attack\n');
simple_param_decode(flag, D0, D1, FRAG, msg, bits);

flag = flag + 1;
movefile('hide.wav', 'hide_no_noise.wav', 'f');
passchannel(25, 'hide_no_noise.wav', 'hide.wav');%25
fprintf('noise-gaussian\n');
simple_param_decode(flag, D0, D1, FRAG, msg, bits);

flag = flag + 1;
movefile('hide.wav', 'hide_gaussian.wav', 'f');
resample_attack(16000);
fprintf('resample-attack\n');
simple_param_decode(flag, D0, D1, FRAG, msg, bits);

flag = flag + 1;
movefile('hide.wav', 'hide_resample.wav', 'f');
load lpf.mat;
[fil, fs] = audioread('hide_no_noise.wav');
y = filter(Num, 1, fil);
audiowrite('hide.wav', y, fs);
fprintf('filter-attack\n');
simple_param_decode(flag, D0, D1, FRAG, msg, bits);
movefile('hide.wav', 'hide_filter.wav', 'f');

%Ƶ��ͼ����
[s1, fs] = audioread('hide_no_noise.wav');
n = length(s1);
fft_y1=fftshift(fft(s1));
x=linspace(3000,4000,n/8);
mid = abs(fft_y1);
y1 = mid(420001:n,1);

[s2, fs] = audioread('hide_filter.wav');
fft_y2=fftshift(fft(s2));
mid = abs(fft_y2);
y2 = mid(420001:n,1);
subplot(221);
plot(x,y1,'b-');
xlabel('Ƶ��');
ylabel('���');
title('�޹���ʱ��Ƶ��3000Hz-4000HzƵ��ͼ');
subplot(222);
plot(x,y2,'r-');
xlabel('Ƶ��');
ylabel('���');
title('��ͨ�˲�����Ƶ��3000Hz-4000HzƵ��ͼ');
subplot(223);
plot(x,y1,'b-',x,y2,'r-');
xlabel('Ƶ��');
ylabel('���');
title('��ͨ�˲�ǰ����Ƶ����Ƶ��ͼ�Ƚ�');