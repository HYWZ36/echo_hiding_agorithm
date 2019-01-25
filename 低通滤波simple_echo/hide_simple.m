function o = hide_simple(d0, d1, fragment, data, s, atten)
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
s0 = atten * [zeros(1, d0), s(1:len - d0)];%backward echo with delay 0
s1 = atten * [zeros(1, d1), s(1:len - d1)];%backward echo with delay 1

i = 0;
N = floor(len / fragment);
lend = length(data);
o = s0;
for i = 0 : N - 1
    if((i + 1) > lend)
        bit = 0;
    else
        bit = data(i + 1);
    end;
    if bit == 1
        st = i * fragment + 1;
        ed = (i + 1) * fragment;
        o(st : ed) = s1(st : ed);
    end;
end;
o = s + o;

%���������
Ps = sum(s.^2);
Pn = sum((o - s).^2);
%fprintf('%f\t%f\t', Ps, Pn);
SNR = 10 * log10(Ps / Pn);
%xlswrite('simple_data.xlsx',SNR,3,'B5');
fprintf('SNR:%f\n', SNR);