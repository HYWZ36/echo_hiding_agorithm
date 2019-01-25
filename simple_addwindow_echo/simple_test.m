clear all;
close all;
clc;
attens = [0.7];
D = [40 ;60 ];
FRAGS = [1024];
num = 0;
global x;
% 0 10 100 1000 10000 100000 150000
for i = [100000]
    x = i;
    for aItem = attens
        for fItem = FRAGS
            for DItem = D
    %             DItem(1,:)
    %             DItem(2,:)
                D0 = DItem(1,:);
                D1 = DItem(2,:);
                FRAG = fItem;
                atten = aItem;
                fprintf('*****************************************************\n')
                fprintf('X:%d,D0:%d D1:%d FRAG:%d atten:%f\n',x,D0,D1,FRAG,atten);
                msg = 'abcdefghijklmnopqrstuvwxyz0123456789';
                %���ص�����bits��msg�Ķ����Ƶ���ʽ��s����֮�����Ƶ�ļ� �����ǽ��е�������������
                [bits, s] = simple_param_code(D0, D1, FRAG, atten, msg);
                simple_param_decode(D0, D1, FRAG, msg, bits); 
                %��������Ǹ����ļ�������
                fileName = strcat('hide_no_noise',num2str(x));
                fileName = strcat(fileName,'.wav');
                %num = 1+num
                %��hide.wav����һ�ݴ��fileName�ĸ�ʽ
                [s, fs] = audioread('hide.wav');
                audiowrite(fileName, s, fs);
                fprintf('*****************************************************\n')
            end
        end
    end
end



