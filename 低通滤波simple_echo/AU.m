function AU(varargin)
error(nargchk(0,1,nargin));
if nargin == 0
    [fn, pn] = uigetfile({'*.wav', 'WAV Files(*.wav)'}, '选择要压缩解扩的文件');
    infn = strcat(pn, fn);
else
    infn = varargin{1};
end;
y=wavread(infn);
% yA=compand(y,87.6,1,'a/compressor');
yA=compand(y,87.6,1,'A/compressor');
yq = uencode(yA,8);
yqd = udecode(yq,8);
% yAD=compand(yqd,87.6,1,'a/expander');
yAD=compand(yqd,87.6,1,'A/expander');
wavwrite(yAD,8000,16,'ALaw.wav');
% yA=compand(y,255,1,'u/compressor');
yA=compand(y,255,1,'mu/compressor');
yq = uencode(yA,8);
yqd = udecode(yq,8);
% yAD=compand(yqd,255.6,1,'u/expander');
yAD=compand(yqd,255.6,1,'mu/expander');
wavwrite(yAD,8000,16,'muLaw.wav');
