function out = dh_simple(d0, d1, fragment, in)
%out = dh_simple(d0, d1, fragment, in)
%decode using cepstrum
%d0:delay 0
%d1:delay 1
%fragment:fragment
%in:blendation

[row, col] = size(in);
if(row > col)
    in = in';
end;

i = 0;
out = [];
N = floor(length(in) / fragment);
for i = 0 : N - 1
    st = i * fragment + 1;
    ed = (i + 1) * fragment;
    p = in(st : ed);
    p = MyCeps(p);
    d11 = p(1 * d1 + 1);
    d01 = p(1 * d0 + 1);
    if d11 > d01
        out(i + 1) = 1;
    else
        out(i + 1) = 0;
    end;
end;