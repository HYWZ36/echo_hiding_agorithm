function out = dh_simple(D00, D01,D10,D11, fragment, in)
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
    d31 = p(1 * D11 + 1);
    d21 = p(1 * D10 + 1);
    d11 = p(1 * D01 + 1);
    d01 = p(1 * D00 + 1);

    if (d31 > d21)&(d31>d11)&(d31>d01)
        out(2*i + 1) = 1;
        out(2*i + 2) = 1;
    elseif (d21 > d11)&(d21>d01)
        out(2*i + 1) = 1;
        out(2*i + 2) = 0;
    elseif d11 > d01
        out(2*i + 1) = 0;
        out(2*i + 2) = 1;
    else 
        out(2*i + 1) = 0;
        out(2*i + 2) = 0;
    end;

end;