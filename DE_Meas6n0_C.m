%ȥǶ�������
function [DEMS] = DE_Meas6n0_C()

freq=0.5e9:0.2e9:5.1e9;
w=2*pi*freq;

%file_input=('QuantumVgsfu2Vds28.dat');
% file_input=('S_Para_0_10_230307.dat');
% file_input=('S_Para_N2_28_230308.dat');
%file_input=('S_Para_N1_24_230309.dat');
% file_input=('S_Para_N1_12_230318.dat');
file_input=('S_Para_N1_14_230319.dat');
format long 
s=load(file_input);  %���������ļ�ΪS����
%% S������ʵ��&�鲿���ʽ
rs11=s(:,2);%�����ļ��ĵ�2�и�ֵ��rs11��S11��ʵ����
is11=s(:,3);%�����ļ��ĵ�3�и�ֵ��is11��S11���鲿��
rs12=s(:,4);
is12=s(:,5);
rs21=s(:,6);
is21=s(:,7);
rs22=s(:,8);
is22=s(:,9);
%S�����ĸ������ʽ
s11 = rs11 + 1i*is11;
s12 = rs12 + 1i*is12;
s21 = rs21 + 1i*is21;
s22 = rs22 + 1i*is22;

%% S�������ݴ洢
DE_data.x = [];
DE_abcd = repmat(DE_data,101,1);%101*1�ľ������ڴ洢S����ֵ
for n=1:101
DE_abcd(n).x = [s11(n)./1000,s12(n)./1000;s21(n)./1000,s22(n)./1000];%      
end
DEMS = DE_abcd;
end

