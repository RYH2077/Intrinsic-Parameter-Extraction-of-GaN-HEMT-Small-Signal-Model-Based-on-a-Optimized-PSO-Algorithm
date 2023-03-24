% Author   : Yuhao Ren
% Github   : https://github.com/Ren-yuhao
% File     : model_errorNew.m
% Date     : 2022-12-25
% Version  : V1.0
% Brief    : 平均绝对误差（MAE）评估拟合效果
% Update   : 2022-12-25@Haiyi Cai: original.
%            2023-01-04@Yuhao Ren: simplify.
% Attention: Copyright(C) 2022-2023 Ren Yuhao, all rights reserved.
% -------------------------------------------------------------------------
% Reference
% [1].  
%
function error = model_errorNew(DEMS,Model)
% num=101;
% % 初始化
% %er11=0;
% % er12=0;
% % er21=0;
% % er22=0;
% % for n=1:num  %num
% %     er11= er11 + mean(abs(DEMS(n).x(1,1)-Model(n).x(1,1)));
% %     er12= er12 + mean(abs(DEMS(n).x(1,2)-Model(n).x(1,2)));
% %     er21= er21 + mean(abs(DEMS(n).x(2,1)-Model(n).x(2,1)));
% %     er22= er22 + mean(abs(DEMS(n).x(2,2)-Model(n).x(2,2)));
% % end
% %error=((er11+er12+er21+er22))./4./num;%整体误差
% error = 0;
% rS11=zeros(num,1);
% iS11=zeros(num,1);
% rS12=zeros(num,1);
% iS12=zeros(num,1);
% 
% rS21=zeros(num,1);
% iS21=zeros(num,1);
% rS22=zeros(num,1);
% iS22=zeros(num,1);
% 
% maxA=zeros(4,2);
% %caculat max
% for n=1:101
%     rS11(n)=abs(real(DEMS(n).x(1,1)));
%     iS11(n)=abs(imag(DEMS(n).x(1,1)));
%     rS12(n)=abs(real(DEMS(n).x(1,2)));
%     iS12(n)=abs(imag(DEMS(n).x(1,2)));
%     rS21(n)=abs(real(DEMS(n).x(2,1)));
%     iS21(n)=abs(imag(DEMS(n).x(2,1)));
%     rS22(n)=abs(real(DEMS(n).x(2,2)));
%     iS22(n)=abs(imag(DEMS(n).x(2,2)));
% end
% [~, RSO] = sort(rS11); % 鍗囧簭鎺掑垪--1/y
% rS11 = rS11(RSO);
% [~, RSO] = sort(iS11); % 鍗囧簭鎺掑垪--1/y
% iS11 = iS11(RSO);
% [~, RSO] = sort(rS12); % 鍗囧簭鎺掑垪--1/y
% rS12 = rS12(RSO);
% [~, RSO] = sort(iS12); % 鍗囧簭鎺掑垪--1/y
% iS12 = iS12(RSO);
% 
% [~, RSO] = sort(rS21); % 鍗囧簭鎺掑垪--1/y
% rS21 = rS21(RSO);
% [~, RSO] = sort(iS21); % 鍗囧簭鎺掑垪--1/y
% iS21 = iS21(RSO);
% [~, RSO] = sort(rS22); % 鍗囧簭鎺掑垪--1/y
% rS22 = rS22(RSO);
% [~, RSO] = sort(iS22); % 鍗囧簭鎺掑垪--1/y
% iS22 = iS22(RSO);
%     
% maxA(1,1)=rS11(num);
% maxA(1,2)=iS11(num);
% maxA(2,1)=rS12(num);
% maxA(2,2)=iS12(num);
% maxA(3,1)=rS21(num);
% maxA(3,2)=iS21(num);
% maxA(4,1)=rS22(num);
% maxA(4,2)=iS22(num);
% % 实际测量S参数最大值
% S_measureMax11 = maxA(1,1) + 1i*maxA(1,2);
% S_measureMax12 = maxA(2,1) + 1i*maxA(2,2);
% S_measureMax21 = maxA(3,1) + 1i*maxA(3,2);
% S_measureMax22 = maxA(4,1) + 1i*maxA(4,2);
% for n = 1:101
%     er11 = abs(abs(DEMS(n).x(1,1)-Model(n).x(1,1)))/abs(S_measureMax11);
%     er12 = abs(abs(DEMS(n).x(1,2)-Model(n).x(1,2)))/abs(S_measureMax12);
%     er21 = abs(abs(DEMS(n).x(2,1)-Model(n).x(2,1)))/abs(S_measureMax21);
%     er22 = abs(abs(DEMS(n).x(2,2)-Model(n).x(2,2)))/abs(S_measureMax22);
%     error = error + (er11+er12+er21+er22)./4;
% end
% error = error/num;
% end

%% 
num   = 101;
error = 0;
%% 实测模型S参数最大值
% % Vgs = 0 Vds = 10
% S_measureMax11 = 1.00409890070649910E0  + (-1.66857990112050381E1)*1i;
% S_measureMax12 = 1.13044594050312752E-1 + (7.52899691654640968E0)*1i;
% S_measureMax21 = 6.14276320198003400E0  + (1.72880398022384085E2)*1i;
% S_measureMax22 = 7.88862359429704263E-1 + (-5.05841058473224248E0)*1i;
% % Vgs = -2 Vds = 28
% S_measureMax11 = 1.005  + (-14.548)*1i;
% S_measureMax12 = 0.040 + (21.737)*1i;
% S_measureMax21 = 7.591  + (174.202)*1i;
% S_measureMax22 = 0.909 + (-1.605)*1i;
% % Vgs = -1 Vds = 12
% S_measureMax11 = 1.007 + (-11.956)*1i;
% S_measureMax12 = 0.090 + (8.988)*1i;
% S_measureMax21 = 7.387 + (172.779)*1i;
% S_measureMax22 = 0.829 + (-4.766)*1i;
% Vgs = -1 Vds = 14
S_measureMax11 = 1.007 + (-16.081)*1i;
S_measureMax12 = 0.077 + (11.162)*1i;
S_measureMax21 = 7.434 + (173.796)*1i;
S_measureMax22 = 0.845 + (-5.696)*1i;
% Vgs = -1 Vds = 24
% S_measureMax11 = 1.007  + (-9.721)*1i;
% S_measureMax12 = 0.042 + (15.373)*1i;
% S_measureMax21 = 7.422  + (174.338)*1i;
% S_measureMax22 = 0.894 + (-3.099)*1i;

%% 误差计算1
% for n = 1:num
%     er11  = abs(abs(DEMS(n).x(1,1)-Model(n).x(1,1)))/abs(S_measureMax11);
%     er12  = abs(abs(DEMS(n).x(1,2)-Model(n).x(1,2)))/abs(S_measureMax12);
%     er21  = abs(abs(DEMS(n).x(2,1)-Model(n).x(2,1)))/abs(S_measureMax21);
%     er22  = abs(abs(DEMS(n).x(2,2)-Model(n).x(2,2)))/abs(S_measureMax22);
%     error = error + (er11+er12+er21+er22)./4;
% end
%% 误差计算2
for n = 1:num
    er11  = abs(abs(real(DEMS(n).x(1,1)-Model(n).x(1,1))+abs(imag(DEMS(n).x(1,1)-Model(n).x(1,1)))))/abs(S_measureMax11);
    er12  = abs(abs(real(DEMS(n).x(1,1)-Model(n).x(1,2))+abs(imag(DEMS(n).x(1,2)-Model(n).x(1,2)))))/abs(S_measureMax12);
    er21  = abs(abs(real(DEMS(n).x(2,1)-Model(n).x(2,1))+abs(imag(DEMS(n).x(2,1)-Model(n).x(2,1)))))/abs(S_measureMax21);
    er22  = abs(abs(real(DEMS(n).x(2,2)-Model(n).x(2,2))+abs(imag(DEMS(n).x(2,2)-Model(n).x(2,2)))))/abs(S_measureMax22);
    error = error + (er11+er12+er21+er22)./4;
end
error = error/num;

end
