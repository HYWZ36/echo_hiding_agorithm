function passchannel(varargin)
error(nargchk(1,3,nargin));
snr = varargin{1};
if nargin == 1
    [fn, pn] = uigetfile({'*.wav', 'WAV Files(*.wav)'}, 'ѡ��Դ�ļ�');
    infn = strcat(pn, fn);
    [fn, pn] = uiputfile({'*.wav', 'WAV Files(*.wav)'}, '�ļ����Ϊ');
    outfn = strcat(pn, fn);
end;
if nargin == 3
    infn = varargin{2};
    outfn = varargin{3};
end;
% x = wavread(infn); %the function is deprecated by the new version
[x,fs] = audioread(infn);
y = awgn(x, snr, 'measured');
% wavwrite(y, 8000, outfn);
audiowrite(outfn, y, fs);
