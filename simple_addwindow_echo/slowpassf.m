function lfdata=slowpassf(f,fdata,fc)
N=length(f);
df=f(2)-f(1);
fs=N*df;
lowpa=zeros(1,N);
lfdata=zeros(1,N);
wc=fc*2*pi;
for h=0:N-1
    w=h*df*2*pi;
    if w>2*pi*fs/2
        w=w-2*pi*fs;
    end
    lowpa(h+1)=1/(1-(w/wc)^2+i*sqrt(2)*(w/wc));
end
lfdata=lowpa.*fdata;
w1=[0:df:fs-df];
% subplot(2,1,1);
% plot(w1,abs(lowpa));
% xlabel('频率');
% ylabel('低通滤波器响应');
% subplot(2,1,2);
% plot(w1,abs(lfdata));
% xlabel('频率');
% ylabel('低通滤波后频谱');
% pause;

    