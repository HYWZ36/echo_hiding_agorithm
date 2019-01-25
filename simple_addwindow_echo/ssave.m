function ssave(t,tdata,filename)
fs=1/(t(2)-t(1));
%audiowrite(filename,y,Fs,Name
audiowrite(filename,tdata,fs);
return;