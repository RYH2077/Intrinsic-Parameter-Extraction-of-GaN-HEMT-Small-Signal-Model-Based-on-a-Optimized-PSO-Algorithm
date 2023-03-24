% Author    : Yuhao Ren
% Github    : https://github.com/Ren-yuhao
% File      : Model_S_Para.m
% Date      : 2023-01-03
% Version   : V1.0
% Brief     : 去嵌的逆过程（Sint-Z-Y-S）得到完整信号模型的S参数（19元件）
% Update    : 2023-01-03: original@Yuhao Ren
%             
% Attention : Copyright(C) 2022-2023 RYH, all rights reserved.
% -------------------------------------------------------------------------
% References
% [1].尹成功. 毫米波GaN基HEMT小信号建模和参数提取[D].电子科技大学,2014.
% [2].Jarndal A ,  Kompa G . A new small-signal modeling approach applied to
%     GaN devices[J]. IEEE Transactions on Microwave Theory and Techniques, 
%     2005, 53(11):3440-3448.
% -------------------------------------------------------------------------
function Sm = Model_S_Para(Cpg, Cpd, Cpgd, Lg, Ld, Ls, Rg, Rd, Rs, Ri, Rds, Rgd, gm, tau, Cgd, Cgs, Cds, Rgsf, Rgdf)
num = 101;
freq = 0.3e9;

for n=1:num
    w = 2*pi*(freq + (0.2e9)*n);
%     D1 = 1+(w*Ri*Cgs)^2;
%     D2 = 1+(w*Rgd*Cgd)^2;
    Ggsf = 1/Rgsf;
    Ggdf = 1/Rgdf;
%     Yint_11(n) = Ggsf + Ggdf + (w*Cgs)^2*Ri/D1 + (w*w*Cgd)^2*Rgd/D2 + 1i*w*((Cgs/D1) + (Cgd/D2));
%     Yint_12(n) = -Ggdf -  (w*w*Cgd)^2*Rgd/D2 - 1i*w*Cgd/D2;
%     Yint_21(n) = -Ggdf - (gm*exp(-1i*w*tau))/(1 + 1i*w*Ri*Cgs) - 1i*w*Cgd/(1 + 1i*w*Rgd*Cgd);
%     Yint_22(n) = Ggsf +1/Rds + (w*w*Cgd)^2*Rgd/D2 + 1i*w*(Cds + (Cgd/D2));
%     Yint(n).x = [Yint_11(n), Yint_12(n);Yint_21(n), Yint_22(n)];
    
    Ygs = (Ggsf + 1i*w*Cgs)/(1 + Ri*Ggsf + 1i*w*Ri*Cgs);
    Ygm = gm*exp(-1i*w*tau)/(1 + Ri*Ggsf + 1i*w*Cgs);
    Yds = 1/Rds + 1i*w*Cds;
    Ygd = (Ggdf + 1i*w*Cgd)/(1 + Rgd*Ggdf + 1i*w*Rgd*Cgd);
    Yint(n).x = [Ygs+Ygd, -Ygd; Ygm-Ygd, Yds+Ygd];
%     w=2*pi*(freq+(0.2e9)*n);
%     Ygs=(1/Rgsf+1i*w*Cgs)/(1+Ri/Rgsf+1i*w*Ri*Cgs);
%     Y12=-(1/Rgdf+1i*w*Cgd)/(1+Rgd/Rgdf+1i*w*Rgd*Cgd);
%     Ygm=gm*exp(-1i*w*tau);%/(1+ri*Ggsf+1i*w*cgs);
%     Yds=1/Rds+1i*w*Cds;
%     Yint(n).x=[Ygs-Y12, Y12; (Ygm+Y12),(Yds-Y12)];%本征部分Y参数
    %Yint - Z1  引入寄生电阻
    Z1(n).x = y2z(Yint(n).x);
    Z1(n).x = Z1(n).x + [Rs+Rg, Rs; Rs, Rs+Rd];
    %Z1 - Y 引入寄生电容
    Y(n).x = z2y(Z1(n).x);
    Y(n).x = Y(n).x + [1i*w*(Cpg+Cpgd), -1i*w*Cpgd; -1i*w*Cpgd, 1i*w*(Cpd+Cpgd)];
    %Y - Z2 引入寄生电感
    Z2(n).x = y2z(Yint(n).x);
    Z2(n).x = Z2(n).x + [1i*w*Lg, 1i*w*Ls; 1i*w*Ls, 1i*w*Ld];
    %Z2 - S 得到模型S参数
    S(n).x = z2s(Z2(n).x);
    S(n).x=[S(n).x(1,1),S(n).x(1,2);S(n).x(2,1),S(n).x(2,2)];
%     % Yint convert to Sint
%     Sint(n).x = y2s(Yint(n).x);
%     % Sint convert to Z
%     Z(n).x = Sint(n).x + [Rs+Rg+1i*w*Lg, Rs+1i*w*Ls;Rs+1i*w*Ls, Rs+Rd+1i*w*Ld];
%     % Z convert to Y
%     Y(n).x = Z(n).x + [1i*w*(Cpg+Cpgd), 1i*w*Cpgd;1i*w*Cpgd, 1i*w*(Cpd+Cpgd)];
%     % Y convert to S
%     S(n).x = y2s(Y(n).x);
end
Sm = S;%完整信号模型S参数

end