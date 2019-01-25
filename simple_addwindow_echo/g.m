function o = g(len,a,b)
%[1,a] [a+1,len-b] [len-b+1,len]
o = ones(1,len);
o(a+1:len-a)=1;
x =  1:len;
%直线
o(1:a) = (0:a-1)./a;
o(len-a+1:len) = (a-1:-1:0)./a;
plot(x,o,'r+');
hold on

%sin
o(1:a) = sin((0:a-1)./a*(pi/2));
o(len-a+1:len) = sin((a-1:-1:0)./a*(pi/2));
plot(x,o,'y+');
hold on

%log  
o(1:a) = log((1:a))/log(a);
o(len-a+1:len) = log((a:-1:1))/log(a);
plot(x,o,'b+');
hold on

%平方
o(1:a) = ((0:a-1)./a).^2;
o(len-a+1:len) = ((a-1:-1:0)./a).^2;
plot(x,o,'g+');
hold on

%根号
% o(1:a) = sqrt((0:a-1)./a);
% o(len-a+1:len) = sqrt((a-1:-1:0)./a);
% plot(x,o,'+');
% hold on

legend("直线","sin","log","平方");

