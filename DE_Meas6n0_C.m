%去嵌后的数据
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
s=load(file_input);  %输入数据文件为S参数
%% S参数的实部&虚部表达式
rs11=s(:,2);%数据文件的第2列赋值给rs11（S11的实部）
is11=s(:,3);%数据文件的第3列赋值给is11（S11的虚部）
rs12=s(:,4);
is12=s(:,5);
rs21=s(:,6);
is21=s(:,7);
rs22=s(:,8);
is22=s(:,9);
%S参数的复数表达式
s11 = rs11 + 1i*is11;
s12 = rs12 + 1i*is12;
s21 = rs21 + 1i*is21;
s22 = rs22 + 1i*is22;

%% S参数数据存储
DE_data.x = [];
DE_abcd = repmat(DE_data,101,1);%101*1的矩阵，用于存储S参数值
for n=1:101
DE_abcd(n).x = [s11(n)./1000,s12(n)./1000;s21(n)./1000,s22(n)./1000];%      
end
DEMS = DE_abcd;
end

