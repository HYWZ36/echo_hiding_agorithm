function [bits,s] = simple_param_code(D0, D1, FRAG, ATTEN, msg)
%function [msg, bits, code1,code2, s, err] = simple_param_code(D0, D1, FRAG, ATTEN, msg)
%D0:delay 0
%D1:delay 1
%FRAG:fragment
%ATTEN:attenuation of echo


%return value
%bits:original bits
%s:the original  voice


bits = str2bit(msg);
%对原是音频进行扩充
[s, fs] = audioread('man.wav');%audioread
s = s';
s_len = length(s);
t_len = length(bits) * FRAG;
if s_len < t_len
    multiple = floor(t_len / s_len);
    remainder = mod(t_len, s_len);
    tmp = [];
    for i = 1:multiple
        tmp = [tmp s];
    end;
    tmp = [tmp s(1:remainder)];
    s = tmp;
end;
    
%hide information
bld = hide_simple(D0, D1, FRAG, bits, s, ATTEN);
I = s;
In = bld;

snr=0; 
Ps=sum((I-(mean(I))).^2);%signal power 
Pn=sum((I-In).^2); %noise power 
snr=10*log10(Ps/Pn); % 其中I是纯信号，In是带噪信号，snr是信噪比
f = snr;
fprintf('SNR:%f\n',f);
%save voice file that is going to send
audiowrite('hide.wav', bld, fs);