function [t,tdata]=sload(filename)
[datatemp,fs]=audioread(filename);
tdata=datatemp';
t=[0:1/fs:(length(tdata)-1)/fs];
return