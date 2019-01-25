function y = fwd_param_simple(D0, D1, FRAG, msg, bits)
%function fwd_param_simple(D0, D1, FRAG, msg, bits)
%D0:delay 0
%D1:delay 1
%FRAG:fragment
%msg:the scuryt text
%bits:original bits

fid = 1;

y = audioread('hide.wav')';
    
out = dh_simple(D0, D1, FRAG, y);

len = min(length(bits), length(out));
rate = sum(abs(bits(1:len)-out(1:len)))/len;
fprintf(fid, 'len:%d\t error rate:%f\t error num:%d\n', len, rate, len * rate);

%printf error code rate
dc_msg = sprintf('%s', bit2str(out(1:len)));
len = min([length(msg), length(dc_msg)]);
if len ~= 0
    err = zeros(1, len);
    for n = 1:len
        err(n) = 1 - strcmp(msg(n), dc_msg(n));
    end;
    fprintf(fid, 'the text you send is:%s\nlen is:%d\n', dc_msg(1:len), len);
    fprintf(fid, 'error code rate is:%f\n', sum(err) / len);
else
    fprintf(fid, 'too much error, msg can not be recovered!\n');
end;

