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
%���������Ӻ�Ļ���
s0 = atten * [zeros(1, d0), s(1:len - d0)];%backward echo with delay 0
s1 = atten * [zeros(1, d1), s(1:len - d1)];%backward echo with delay 1
%s��ԭ����������Ϣ
i = 0;
%��ȡ��Ƭ������
N = floor(len / fragment);
%data����Ҫ���ص����ݵĳ���
lend = length(data);

%o����Ҫ���ص�0����
o = s0;
%��ʼ����ÿ����Ƭ
for i = 0 : N - 1
    %�����Ҫ���ص������Ѿ��������˾Ͳ���������
    if((i + 1) > lend)
        bit = 0;
    else
    %û�����صĻ���ȡ��Ҫ���ص�������0 or 1
        bit = data(i + 1);
    end;
    %�����Ҫ���ص���Ϣʱ1�Ļ�
    if bit == 1
        st = i * fragment + 1;
        ed = (i + 1) * fragment;
        o(st : ed) = s1(st : ed);
    end;
end;
%o �ǵ��ӵ�����
%�������һ���� �Ի������м򵥵Ĵ���
len_data = length(o);
%���������ݽ�ȥ�Ĳ���Ϊ����Ϣ�ĳ��ȣ�ǰ����Ҫ�ĳ��ȡ�
o = o.*g(length(o),x,x);
o = s + o;


