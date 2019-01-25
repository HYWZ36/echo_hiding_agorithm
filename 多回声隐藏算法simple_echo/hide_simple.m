function o = hide_simple(D00, D01,D10,D11, fragment, data, s, atten)
%function o = hide_simple(d0, d1, fragment, data, s, atten)
%d0:delay 0
%d1:delay 1
%fragment:fragment
%data:the information
%s:source voice
%atten:attenuation of echo
[row, col] = size(s);
if(row > col)
    s = s';
end;

len = length(s);
s0 = atten * [zeros(1, D00), s(1:len - D00)];%backward echo with delay 00
s1 = atten * [zeros(1, D01), s(1:len - D01)];%backward echo with delay 01
s2 = atten * [zeros(1, D10), s(1:len - D10)];%backward echo with delay 10
s3 = atten * [zeros(1, D11), s(1:len - D11)];%backward echo with delay 11

i = 0;
N = floor(len / fragment);
lend = length(data);
o = s0;
for i = 0 : N - 1
    if((2*i + 2) > lend)
        bit = 0;
    else
        bit = 2 * data(2*i + 1) + data(2*i + 2);
    end;
    if bit == 1
        st = i * fragment + 1;
        ed = (i + 1) * fragment;
        o(st : ed) = s1(st : ed);
    end;
    if bit == 2
        st = i * fragment + 1;
        ed = (i + 1) * fragment;
        o(st : ed) = s2(st : ed);
    end;
    if bit == 3
        st = i * fragment + 1;
        ed = (i + 1) * fragment;
        o(st : ed) = s3(st : ed);
    end;
end;
o = s + o;
f = psnr(s, o);
fprintf(1, 'psnr:%f\n', f);