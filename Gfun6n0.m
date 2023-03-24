%---------------------------File Details-----------------------------------
% Author   : Ren Yuhao
% Github   : https://github.com/Ren-yuhao
% File     : Fitness_Function.m
% Date     : 2022-12-25
% Version  : V1.0
% Brief    : 求适应值 功能函数
% Reference: [1].https://blog.csdn.net/qq_44589327/article/details/105371963
%            [2].
% --------------------------Modify History---------------------------------
% 2022-12-25: original@RenYuhao
% -------------------------------------------------------------------------
% Attention: Copyright(C) 2022-2023 Ren Yuhao, all rights reserved.
%--------------------------------------------------------------------------

function y = Gfun6n0(X)
% Initialize the fitting parameters----------------------------------------
% K1~K10-->X(1)~X(10)
% Capacities
% cpg=216.672.*1e-15;
% cpgd=44.975.*1e-15;
% cpd=51.351.*1e-15;
% cgd = X(4)*1e-12;
% cgs = X(1)*1e-12;%cgd=cgs
% cds = X(10)*1e-12;
% cpgi=572.63*1e-15;
% cpdi=262.382*1e-15;
% 
% % Inductors
% lg=32.24.*1e-12;
% ld=32.223.*1e-12;
% ls=1.*1e-12;
% rg=0.9368;
% rd=0.7147;
% rs=0.1;
% 
% % Resistors & others
% ri = X(2);
% rds = X(9);
% rgd = X(5);
% gm = X(8);
% tau =X(7)*1e-12;
% Rgsf = X(3)*1000;
% Rgdf = X(6)*1000;
% 
% [Model] = GWOmod_C(cpg,cpd,cpgd,lg,ld,ls,rg,rd,rs, ri,rds,rgd,gm,tau,cgd,cgs,cds,Rgsf,Rgdf,cpgi,cpdi);
% [DEMS] = DE_Meas6n0_C();

%[E1,E2] = IN_check(DEMS,Model);

% Cpg=216.672.*1e-15;
% Cpgd=44.975.*1e-15;
% Cpd=51.351.*1e-15;
% Cgd = X(4)*1e-12;
% Cgs = X(1)*1e-12;%cgd=cgs
% Cds = X(10)*1e-12;
% 
% % Inductors
% Lg=32.24.*1e-12;
% Ld=32.223.*1e-12;
% Ls=1.*1e-12;
% Rg=0.9368;
% Rd=0.7147;
% Rs=0.1;
% 
% % Resistors & others
% Ri = X(2);
% Rds = X(9);
% Rgd = X(5);
% gm = X(8);
% tau =X(7)*1e-12;
% Rgsf = X(3)*1000;
% Rgdf = X(6)*1000;
% Cpgi=0;
% Cpdi=0;
%% 寄生参数
% 电容
Cpg  = 153.339.*1e-15; %fF
Cpgd = 0.*1e-15;%fF
Cpd  = 110.151.*1e-15;%fF
% 电阻
Rg   = 2.160;%Ohm
Rd   = 9.103;%Ohm
Rs   = 1.638;%Ohm
% 电感
Lg   = 48.079.*1e-12;%pH
Ld   = 32.223.*1e-12;%pH
Ls   = 13.515.*1e-12;%pH

%% 本征参数
% 电容
Cgd  = X(1)*1e-15;
Cgs  = X(2)*1e-15;
Cds  = X(3)*1e-15;
% Resistors & others
Ri   = X(4);
Rds  = X(5);
Rgd  = X(6);
Rgsf = X(7)*1000;
Rgdf = X(8)*1000;
gm   = X(9);
tau  = X(10)*1e-12;

% Cpgi = 0;
% Cpdi = 0;
S_Model = Model_S_Para(Cpg, Cpd, Cpgd, Lg, Ld, Ls, Rg, Rd, Rs, Ri, Rds, Rgd, gm, tau, Cgd, Cgs, Cds, Rgsf, Rgdf);
%S_Model = GWOmod_C(Cpg, Cpd, Cpgd, Lg, Ld, Ls, Rg, Rd, Rs, Ri, Rds, Rgd, gm, tau, Cgd, Cgs, Cds, Rgsf, Rgdf);
[DEMS] = DE_Meas6n0_C();

[E2] = model_errorNew(DEMS,S_Model);%模型误差

y=(E2);

end
