% Author   : Yuhao Ren
% Github   : https://github.com/Ren-yuhao
% File     : main.m
% Date     : 2022-12-25
% Version  : V1.0
% Brief    : 基于粒子群算法（PSO）的器件拟合参数优化
%            --------------------------------------------------------------
%            缺点：1.易陷入局部极值；2.收敛速度慢
%            --------------------------------------------------------------
%            思路： 已知信号模型所有参数，由已知的本征参数得到本征Y参数（Yint）
%            （相当于去嵌后的Y参数），由去嵌的逆过程（Yint-Sint–Z–Y–S）得到完整
%            信号模型的S参数（由函数GWOmod()实现)。然后与所给实测模型的S参数比较
%            求得误差。在迭代的整个过程中由PSO算法不断优化调整本征参数，直至达到
%            最大迭代次数，并得到最终优化后的参数值。-------[以优化本征参数为例]
%            --------------------------------------------------------------
%            PSO算法改进：非线性自适应惯性权重策略
%            --------------------------------------------------------------
% Update   : 2022-12-25@Haiyi Cai: original
%            2023-03-02@Yuhao Ren: 采用一种动态自适应PSO改进算法
%                                  -----------------Comparison-------------
%                                  | Para. |  Original   |    Optimizatio |
%                                  ----------------------------------------
%                                  |收敛速度|iteration=80 |   iteration=30 |   
%                                  ----------------------------------------
%                                  |参数极值|number=3~5   |    number=0~1  |
%                                  ----------------------------------------
% Attention: Copyright(C) 2022-2023 Ren Yuhao, all rights reserved.
% -------------------------------------------------------------------------
% Reference
% [1]. https://blog.csdn.net/qq_44589327/article/details/105371963
% [2]. 王生亮,刘根友.一种非线性动态自适应惯性权重PSO算法[J].计算机仿真,2021,38(04)
%      :249-253+451.
% -------------------------------------------------------------------------
%% 清空环境
clear;clc;close;
tic %启动秒表计时（记录函数运行时间）
%% PSO Parameter Set
c1=1.2;               %学习因子
c2=1.2;               %学习因子
Dimension=10;         %拟合参数个数
Size=20;              %设置粒子规模大小
Tmax=40;              %最大迭代次数
Vmaximum=20;          %粒子最大速度

%% 参数范围设置（本征）
% k1max=6;k1min=4.5;
% k2max=1;k2min=0;
% k3max=100;k3min=50;
% k4max=0.2;k4min=0;
% k5max=50;k5min=10;
% k6max=100;k6min=1;
% k7max=6;k7min=2;
% k8max=1.2;k8min=0.8;
% k9max=90;k9min=60;
% k10max=0.9;k10min=0.6;
%% 参数范围设置（本征）
%% --------------Vgs=0V Vds=10V---------------%
%% Original Limitation
% k1max = 75.62; k1min = 52.15;    %Cgd(fF)
% k2max = 526.3; k2min = 253.9;    %Cgs(fF)
% k3max = 16.64; k3min = 0.1;      %Cds(fF)
% k4max = 7.267; k4min = 0.1;      %Ri(Ohm)
% k5max = 384.5; k5min = 174.8;    %Rds(Ohm)
% k6max = 60.57; k6min = 0.1;      %Rgd(Ohm)
% k7max = 300;   k7min = 100;       %Rgsf(kOhm)
% k8max = 300;   k8min = 100;       %Rgdf(kOhm)
% k9max = 13.18; k9min = 1;        %tau(ps)
% k10max= 0.128; k10min= 0.08;     %gm(S)
%% Changed Limitation
% k1max = 62;  k1min = 57;     %Cgd(fF)
% k2max = 370; k2min = 320;    %Cgs(fF)
% k3max = 17;  k3min = 10;     %Cds(fF)
% k4max = 2;   k4min = 0.1;    %Ri(Ohm)
% k5max = 380; k5min = 330;    %Rds(Ohm)
% k6max = 60.57;  k6min = 50;     %Rgd(Ohm)
% k7max = 250;    k7min = 50;     %Rgsf(kOhm)
% k8max = 250;    k8min = 50;     %Rgdf(kOhm)
% k9max = 1.5;    k9min = 0;      %tau(ps)
% k10max= 0.09;   k10min= 0.08;   %gm(S)

%% --------------Vgs=-2V Vds=28V-------------%
%%  Original Limitation
% k1max = 16.8;  k1min = 6.34;     %Cgd(fF)
% k2max = 679.4; k2min = 366.1;    %Cgs(fF)
% k3max = 6.855; k3min = 0;        %Cds(fF)
% k4max = 5.311; k4min = 0;        %Ri(Ohm)
% k5max = 1025;  k5min = 246.3;    %Rds(Ohm)
% k6max = 350;   k6min = 0;        %Rgd(Ohm)
% k7max = 300;   k7min = 50;       %Rgsf(kOhm)
% k8max = 300;   k8min = 50;       %Rgdf(kOhm)
% k9max = 1.643; k9min = 0.261;    %tau(ps)
% k10max= 0.151; k10min= 0.09278;  %gm(S)
%%  Changed Limitation
% k1max = 17;  k1min = 10;   %Cgd(fF)
% k2max = 400; k2min = 360;    %Cgs(fF)
% k3max = 10;  k3min = 0;     %Cds(fF)
% k4max = 6;   k4min = 0.1;    %Ri(Ohm)
% k5max = 820; k5min = 700;    %Rds(Ohm)
% k6max = 350; k6min = 320;    %Rgd(Ohm)
% k7max = 200; k7min = 50;     %Rgsf(kOhm)
% k8max = 200; k8min = 50;     %Rgdf(kOhm)
% k9max = 1;   k9min = 0.2;    %tau(ps)
% k10max= 0.10; k10min= 0.09;  %gm(S)
%% --------------Vgs=-1V Vds=12V-------------%
%%  Original Limitation
% k1max = 39.2;  k1min = 51.69;    %Cgd(fF)
% k2max = 310.1; k2min = 577.2;    %Cgs(fF)
% k3max = 24.25; k3min = 0;        %Cds(fF)
% k4max = 4.825; k4min = 0.1;      %Ri(Ohm)
% k5max = 518.0; k5min = 199.0;    %Rds(Ohm)
% k6max = 40.1;  k6min = 0;        %Rgd(Ohm)
% k7max = 300;   k7min = 50;       %Rgsf(kOhm)
% k8max = 300;   k8min = 50;       %Rgdf(kOhm)
% k9max = 0.12;  k9min = 0;        %tau(ps)
% k10max= 0.158; k10min= 0.0934;   %gm(S)
%%  Changed Limitation
% k1max = 48;    k1min = 40;     %Cgd(fF)
% k2max = 400;   k2min = 360;    %Cgs(fF)
% k3max = 26;    k3min = 20;     %Cds(fF)
% k4max = 2;     k4min = 0.1;     %Ri(Ohm)
% k5max = 450;   k5min = 410;    %Rds(Ohm)
% k6max = 40.1;  k6min = 36;     %Rgd(Ohm)
% k7max = 200;   k7min = 100;     %Rgsf(kOhm)
% k8max = 200;   k8min = 100;     %Rgdf(kOhm)
% k9max = 1;   k9min = 0;       %tau(ps)
% k10max= 0.11;  k10min= 0.09;   %gm(S)
%% --------------Vgs=-1V Vds=14V-------------%
%%  Original Limitation
% k1max = 39.32;  k1min = 25.22;    %Cgd(fF)
% k2max = 603.9;  k2min = 308.7;    %Cgs(fF)
% k3max = 20.63; k3min = 0;        %Cds(fF)
% k4max = 7.264; k4min = 0.1;      %Ri(Ohm)
% k5max = 554.7; k5min = 199.9;    %Rds(Ohm)
% k6max = 65.4;  k6min = 0;        %Rgd(Ohm)
% k7max = 300;   k7min = 50;       %Rgsf(kOhm)
% k8max = 300;   k8min = 50;       %Rgdf(kOhm)
% k9max = 4.7;  k9min = 0;        %tau(ps)
% k10max= 0.156; k10min= 0.095;   %gm(S)
%%  Changed Limitation
k1max = 38;    k1min = 34;     %Cgd(fF)
k2max = 450;   k2min = 380;    %Cgs(fF)
k3max = 21;    k3min = 15;     %Cds(fF)
k4max = 1.5;     k4min = 0.1;     %Ri(Ohm)
k5max = 540;   k5min = 460;    %Rds(Ohm)
k6max = 66;    k6min = 60;     %Rgd(Ohm)
k7max = 300;   k7min = 50;    %Rgsf(kOhm)
k8max = 300;   k8min = 50;    %Rgdf(kOhm)
k9max = 0.3;     k9min = 0;      %tau(ps)
k10max= 0.12;  k10min= 0.1;   %gm(S)
%% --------------Vgs=-1V Vds=24V-------------%
% k1max = 18; k1min = 8;       %Cgd(fF)
% k2max = 693; k2min = 325;    %Cgs(fF)
% k3max = 8; k3min = 0;        %Cds(fF)
% k4max = 7; k4min = 1;        %Ri(Ohm)
% k5max = 886; k5min = 213;    %Rds(Ohm)
% k6max = 187; k6min = 0;      %Rgd(Ohm)
% k7max = 300;   k7min = 40;   %Rgsf(kOhm)
% k8max = 300;   k8min = 40;   %Rgdf(kOhm)
% k9max = 5; k9min = 1;        %tau(ps)
% k10max= 0.151; k10min= 0.0900;     %gm(S)
%% 初始化例子的位置与速度
position=zeros(Dimension,Size);
velocity=zeros(Dimension,Size);
% 设置速度上下界
vmax(1:Dimension)=Vmaximum;
vmin(1:Dimension)=-Vmaximum;

%设置位置即拟合参数上下限
xmax=[k1max,k2max,k3max,k4max,k5max,k6max,k7max,k8max,k9max,k10max];
xmin=[k1min,k2min,k3min,k4min,k5min,k6min,k7min,k8min,k9min,k10min];

[position,velocity]=Initial_position_velocity(Dimension,Size,xmax,xmin,vmax,vmin);

pbest_position=position;          %粒子的历史最优位置，初始值为粒子的起始位置，存储每个粒子的历史最优位置
gbest_position=zeros(Dimension,1);%全局最优的那个粒子所在位置，初始值认为是第1个粒子

for j=1:Size
    Pos=position(:,j);          %取第j列10*1，即第j个粒子的位置
    fz(j)=Fitness_Function(Pos);%计算第j个粒子的适应值
end
[gbest_fitness,I]=min(fz);   %求出所有适应值中最小的那个适应值，并获得该粒子的位置
gbest_position=position(:,I);%取最小适应值的那个粒子的位置，即I列

%% 开始循环找到最优解

w_start = 0.9; w_end = 0.4;
for itrtn=1:Tmax %迭代次数1~Tmax
%% 改进方式1（Original）
    disp(itrtn); %显示 第x迭代
%     Weight=w_end+(w_start-w_end)*(Tmax-itrtn)/Tmax;
%     Weight=((0.95-0.4)/(1-Tmax))*(itrtn-1)+0.95;

%% 改进方式2(自适应惯性权重)
%         Weight=w_start-(w_start-w_end)*itrtn/Tmax;                  % 线性递减策略
%         Weight=w_end+(w_start-w_end)*rand;                        % 随机调整
%         Weight=w_end*(w_start/w_end)^(sqrt(1-(itrtn/Tmax)^2));    % 指数递减方式1
%         Weight=w_end*(w_start/w_end)^(1-(itrtn/Tmax)^2);          % 指数递减方式2
%         Weight=w_end*(w_start/w_end)^(1-(itrtn/Tmax));            % 指数递减方式3
%% 改进方式3(非线性动态自适应)-----%         
%% -------------------------------------------------------------begin
%     种群进化离散度参数 
    if itrtn == 1
        k = 1;
    elseif itrtn > 1
        k = std(fz); %适应度值样本标准差
    end
    b = 0.5; %阻尼因子[0,1]
    Weight = w_start + (w_end - w_start)*1/(1 + exp(-10*b*((2*itrtn)/(k*Tmax)-1)));
%% ---------------------------------------------------------------end
    r1=rand(1); %产生一个随机数(值为0~1) 下同
    r2=rand(1);
    %进行速度更新
    for i=1:Size
    velocity(:,i)=Weight*velocity(:,i)+c1*r1*(pbest_position(:,i)-position(:,i))+c2*r2*(gbest_position-position(:,i));  
    end
    %限制速度边界（大于最大速度的用最大速度代替，小于最小速度的用最小速度代替）
    for i=1:Size
        for row=1:Dimension
            if velocity(row,i)>vmax(row)
                velocity(row,i)=vmax(row);
            end
            if velocity(row,i)<vmin(row)
                velocity(row,i)=vmin(row);
            end
        end
    end
    position=position+velocity;%位置更新
    %限制位置边界
    for i=1:Size
        for row=1:Dimension
            if position(row,i)>xmax(row)
                position(row,i)=xmax(row);
            elseif position(row,i)<xmin(row)
                position(row,i)=xmin(row);
            end
        end
    end
    for j=1:Size
        p_position=position(:,j);                 %取一个粒子的位置
        fitness_p(j)=Fitness_Function(p_position);%计算第j个粒子适应度的值
     if fitness_p(j)<fz(j) %粒子的适应值比运动之前的适应值要好，更新原来的适应值
         pbest_position(:,j)=position(:,j);
         fz(j)=fitness_p(j);
     end
     if fitness_p(j)<gbest_fitness
         gbest_fitness=fitness_p(j);%如果该粒子比当前全局适应度的值还好，则代替
     end
  end
  [gbest_fitness_new,I]=min(fz);          %更新后的所有粒子的适应值，取最小的那个，并求出其编号
   best_fitness(itrtn)=gbest_fitness_new; %记录每一代的最好适应值
   % Draw Process of Fitting------------------------------------------BEGIN
   figure(1);subplot(2,2,1);
   plot(best_fitness, 'b.-');
   title('最优适应度进化过程','FontSize',12) 
   xlabel('迭代次数','FontSize',12);
   ylabel('最优适应值','FontSize',12);
   % -------------------------------------------------------------------END
   gbest_position=pbest_position(:,I);%最好适应值对应的个体所在位置
   subplot(2,2,2);hold on
   plot(gbest_position,'rx');
   title('粒子位置分布','FontSize',12);
   xlabel('拟合参数','FontSize',12);
   ylabel('参数值','FontSize',12);
  
end
%% 结果数据输出
subplot(2,2,3);
plot(gbest_position,'ro');
title('最终粒子位置（拟合最优值）','FontSize',12);
xlabel('拟合参数','FontSize',12);
ylabel('参数值','FontSize',12);
for n=1:10
    disp(['k',num2str(n),'拟合参数最优值：',num2str(gbest_position(n))]);
end
disp(['最优适应值为：',num2str(best_fitness(Tmax))]);
%% 获取拟合参数最优值 表格形式
%生成表格行列名称，m行n列
str1='拟合参数值'; str2='k';
m=10;n=1;
column_name=strcat(str1,num2str((1:n)'));
row_name=strcat(str2,num2str((1:m)'));

%表格作图
%set(figure(2),'position',[500 500 500 500]);
uitable(gcf,'Data',gbest_position,'Position',[320 10 200 200],'Columnname',column_name,'Rowname',row_name);
%%
toc
