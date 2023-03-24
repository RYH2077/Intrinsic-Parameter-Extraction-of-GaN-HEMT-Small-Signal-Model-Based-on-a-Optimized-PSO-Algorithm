%%---------------------------File Details------------------------------
 % Author  : Ren Yuhao
 % Github  : https://github.com/Ren-yuhao
 % File    : PSO_Optimization.m
 % Date    : 2023-01-02
 % Version : V1.0
 % Brief   : Îó²î¼ÆËãº¯Êý
 % --------------------------Modify History----------------------------
 % 
 % --------------------------------------------------------------------
 % Attention: Copyright(C) 2022 Ren Yuhao, all rights reserved.
%%---------------------------------------------------------------------

error1=abs(abs(S(1,1))-abs(S(3,3)))/abs(max(S(3,3)));
error2=abs(abs(S(1,2))-abs(S(3,4)))/abs(max(S(3,4)));
error3=abs(abs(S(2,1))-abs(S(4,3)))/abs(max(S(4,3)));
error4=abs(abs(S(2,2))-abs(S(4,4)))/abs(max(S(4,4)));
E1=(error1+error2+error3+error4)/4;

errorS11=sum(abs(abs(S(1,1))-abs(S(3,3)))/abs(max(S(3,3))))/101;
errorS12=sum(abs(abs(S(1,2))-abs(S(3,4)))/abs(max(S(3,4))))/101;
errorS21=sum(abs(abs(S(2,1))-abs(S(4,3)))/abs(max(S(4,3))))/101;
errorS22=sum(abs(abs(S(2,2))-abs(S(4,4)))/abs(max(S(4,4))))/101;
E2=sum(errorS11+errorS12+errorS21+errorS22)/4;

s11