function o = hide_simple(d0, d1, fragment, data, s, atten)
global x;
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
%产生两个延后的回声
s0 = atten * [zeros(1, d0), s(1:len - d0)];%backward echo with delay 0
s1 = atten * [zeros(1, d1), s(1:len - d1)];%backward echo with delay 1
%s是原来的数据信息
i = 0;
%获取分片的数量
N = floor(len / fragment);
%data是需要隐藏的数据的长度
lend = length(data);

%o是需要隐藏的0回声
o = s0;
%开始处理每个分片
for i = 0 : N - 1
    %如果需要隐藏的数据已经隐藏玩了就不用隐藏了
    if((i + 1) > lend)
        bit = 0;
    else
    %没有隐藏的话获取需要隐藏的数据是0 or 1
        bit = data(i + 1);
    end;
    %如果需要隐藏的信息时1的话
    if bit == 1
        st = i * fragment + 1;
        ed = (i + 1) * fragment;
        o(st : ed) = s1(st : ed);
    end;
end;
%o 是叠加的噪声
%在这里加一个窗 对回声进行简单的处理
len_data = length(o);
%窗函数传递进去的参数为，信息的长度，前后需要的长度。
o = o.*g(length(o),x,x);
o = s + o;


