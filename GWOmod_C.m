% Author    : Yuhao Ren
% Github    : https://github.com/Ren-yuhao
% File      : GWOmod.m
% Date      : 2022-12-25
% Version   : V1.0
% Brief     : ȥǶ������̣�Sint-Z-Y-S���õ�����ģ�͵�S������19Ԫ����
% Update    : 2022-12-25: original@Haiyi Cai
%             2022-12-31: simplify@Yuhao Ren
% Attention : Copyright(C) 2022-2023 RYH, all rights reserved.
% -------------------------------------------------------------------------
% References
% [1].���ɹ�. ���ײ�GaN��HEMTС�źŽ�ģ�Ͳ�����ȡ[D].���ӿƼ���ѧ,2014.
% [2].
% -------------------------------------------------------------------------
%%
function [Model] = GWOmod_C(cpg,cpd,cpgd,lg,ld,ls,rg,rd,rs, ri,rds,rgd,gm,tau,cgd,cgs,cds,Rgsf,Rgdf)
%function Model = GWOmod_C(Cpg, Cpd, Cpgd, Lg, Ld, Ls, Rg, Rd, Rs, Ri, Rds, Rgd, Gm, tau, Cgd, Cgs, Cds, Rgsf, Rgdf)
num=101;
freq=0.3e9;
sim_data.x = [];%�ṹ�壬sim_data����x y
sim_data.y = [];
Mod = repmat(sim_data,num,1);%101�?/1列，打包成为结构�?

 for n=1:101 
   %IN-Y-parameters
    w=2*pi*(freq+(0.2e9)*n);
    Ggsf = 1/Rgsf;
    Ggdf = 1/Rgdf;
%     Ygs=(1/Rgsf+1i*w*cgs)/(1+ri/Rgsf+1i*w*ri*cgs);
%     Y12=-(1/Rgdf+1i*w*cgd)/(1+rgd/Rgdf+1i*w*rgd*cgd);
%     Ygm=gm*exp(-1i*w*tau);%/(1+ri*Ggsf+1i*w*cgs);
%     Yds=1/rds+1i*w*cds;
    
    Ygs = (Ggsf + 1i*w*cgs)/(1 + ri*Ggsf + 1i*w*ri*cgs);
    Ygm = gm*exp(-1i*w*tau)/(1 + ri*Ggsf + 1i*w*cgs);
    Yds = 1/rds + 1i*w*cds;
    Ygd = (Ggdf + 1i*w*cgd)/(1 + rgd*Ggdf + 1i*w*rgd*cgd);
    Mod(n).y = [Ygs+Ygd, -Ygd; Ygm-Ygd, Yds+Ygd];
    
    %Mod(n).y=[Ygs-Y12, Y12; (Ygm+Y12),(Yds-Y12)];%��������Y����
    Mod(n).y=y2z(Mod(n).y);
    Mod(n).y=Mod(n).y+[rs,rs;rs,rs];%Z矩阵串联rs
    Mod(n).y=z2abcd(Mod(n).y); %��Z����ת��ΪABCD����
    Mod(n).y=[1,rg;0,1]*Mod(n).y*[1,rd;0,1]; %级联两侧电阻--abcd
    
%   Mod(n).y=[1,0;1i*w*cpgi,1]*Mod(n).y*[1,0;1i*w*cpdi,1]; %级联两侧电容Ci
%   Mod(n).y=abcd2y(Mod(n).y); %Y参数并联Cpgdi
    %Mod(n).y=Mod(n).y+[1i*w*cpgdi,-1i*w*cpgdi;-1i*w*cpgdi,1i*w*cpgdi];%Y参数矩阵--.y
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Mod(n).y=y2abcd(Mod(n).y);
    Mod(n).y=[1,1i*w*lg;0,1]*Mod(n).y*[1,1i*w*ld;0,1];%级联两侧电感--abcd
    Mod(n).y=abcd2z(Mod(n).y);%��shu ju����ת��ΪZ����
    Mod(n).y=Mod(n).y+[1i*w*ls,1i*w*ls;1i*w*ls,1i*w*ls];%Z矩阵串联ls---Z参数矩阵
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Mod(n).y=z2abcd(Mod(n).y);
    Mod(n).y=[1,0;1i*w*cpg,1]*Mod(n).y*[1,0;1i*w*cpd,1];%级联两侧电容Cp
    Mod(n).y=abcd2y(Mod(n).y);%Y参数并联Cpgd   ��shu ju����ת��ΪY����
    Mod(n).y=Mod(n).y+[1i*w*cpgd,-1i*w*cpgd;-1i*w*cpgd,1i*w*cpgd];%Y参数矩阵--.y
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Mod(n).y=[Mod(n).y(1,1),Mod(n).y(1,2);Mod(n).y(2,1),Mod(n).y(2,2)];
    
    Mod(n).x=y2s(Mod(n).y);%��Y����ת��ΪS����
    Mod(n).x=[Mod(n).x(1,1),Mod(n).x(1,2);Mod(n).x(2,1),Mod(n).x(2,2)];
%   Model(n)= Mod(n); ������� �ɲ��������ΪȥǶ����
 end
Model=Mod;
end

%% ȥǶ����
%%




