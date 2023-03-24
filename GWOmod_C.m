% Author    : Yuhao Ren
% Github    : https://github.com/Ren-yuhao
% File      : GWOmod.m
% Date      : 2022-12-25
% Version   : V1.0
% Brief     : 去嵌的逆过程（Sint-Z-Y-S）得到完整模型的S参数（19元件）
% Update    : 2022-12-25: original@Haiyi Cai
%             2022-12-31: simplify@Yuhao Ren
% Attention : Copyright(C) 2022-2023 RYH, all rights reserved.
% -------------------------------------------------------------------------
% References
% [1].尹成功. 毫米波GaN基HEMT小信号建模和参数提取[D].电子科技大学,2014.
% [2].
% -------------------------------------------------------------------------
%%
function [Model] = GWOmod_C(cpg,cpd,cpgd,lg,ld,ls,rg,rd,rs, ri,rds,rgd,gm,tau,cgd,cgs,cds,Rgsf,Rgdf)
%function Model = GWOmod_C(Cpg, Cpd, Cpgd, Lg, Ld, Ls, Rg, Rd, Rs, Ri, Rds, Rgd, Gm, tau, Cgd, Cgs, Cds, Rgsf, Rgdf)
num=101;
freq=0.3e9;
sim_data.x = [];%结构体，sim_data包含x y
sim_data.y = [];
Mod = repmat(sim_data,num,1);%101琛?/1鍒楋紝鎵撳寘鎴愪负缁撴瀯浣?

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
    
    %Mod(n).y=[Ygs-Y12, Y12; (Ygm+Y12),(Yds-Y12)];%本征部分Y参数
    Mod(n).y=y2z(Mod(n).y);
    Mod(n).y=Mod(n).y+[rs,rs;rs,rs];%Z鐭╅樀涓茶仈rs
    Mod(n).y=z2abcd(Mod(n).y); %将Z参数转换为ABCD参数
    Mod(n).y=[1,rg;0,1]*Mod(n).y*[1,rd;0,1]; %绾ц仈涓や晶鐢甸樆--abcd
    
%   Mod(n).y=[1,0;1i*w*cpgi,1]*Mod(n).y*[1,0;1i*w*cpdi,1]; %绾ц仈涓や晶鐢靛Ci
%   Mod(n).y=abcd2y(Mod(n).y); %Y鍙傛暟骞惰仈Cpgdi
    %Mod(n).y=Mod(n).y+[1i*w*cpgdi,-1i*w*cpgdi;-1i*w*cpgdi,1i*w*cpgdi];%Y鍙傛暟鐭╅樀--.y
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Mod(n).y=y2abcd(Mod(n).y);
    Mod(n).y=[1,1i*w*lg;0,1]*Mod(n).y*[1,1i*w*ld;0,1];%绾ц仈涓や晶鐢垫劅--abcd
    Mod(n).y=abcd2z(Mod(n).y);%将shu ju参数转换为Z参数
    Mod(n).y=Mod(n).y+[1i*w*ls,1i*w*ls;1i*w*ls,1i*w*ls];%Z鐭╅樀涓茶仈ls---Z鍙傛暟鐭╅樀
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Mod(n).y=z2abcd(Mod(n).y);
    Mod(n).y=[1,0;1i*w*cpg,1]*Mod(n).y*[1,0;1i*w*cpd,1];%绾ц仈涓や晶鐢靛Cp
    Mod(n).y=abcd2y(Mod(n).y);%Y鍙傛暟骞惰仈Cpgd   将shu ju参数转换为Y参数
    Mod(n).y=Mod(n).y+[1i*w*cpgd,-1i*w*cpgd;-1i*w*cpgd,1i*w*cpgd];%Y鍙傛暟鐭╅樀--.y
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Mod(n).y=[Mod(n).y(1,1),Mod(n).y(1,2);Mod(n).y(2,1),Mod(n).y(2,2)];
    
    Mod(n).x=y2s(Mod(n).y);%将Y参数转换为S参数
    Mod(n).x=[Mod(n).x(1,1),Mod(n).x(1,2);Mod(n).x(2,1),Mod(n).x(2,2)];
%   Model(n)= Mod(n); 矩阵矩阵 可不可以理解为去嵌过程
 end
Model=Mod;
end

%% 去嵌过程
%%




