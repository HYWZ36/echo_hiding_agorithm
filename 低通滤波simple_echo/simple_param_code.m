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

[s, fs] = audioread('source.wav');%audioread
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

%save voice file that is going to send
audiowrite('hide.wav', bld, fs);