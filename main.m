% Author   : Yuhao Ren
% Github   : https://github.com/Ren-yuhao
% File     : main.m
% Date     : 2022-12-25
% Version  : V1.0
% Brief    : ��������Ⱥ�㷨��PSO����������ϲ����Ż�
%            --------------------------------------------------------------
%            ȱ�㣺1.������ֲ���ֵ��2.�����ٶ���
%            --------------------------------------------------------------
%            ˼·�� ��֪�ź�ģ�����в���������֪�ı��������õ�����Y������Yint��
%            ���൱��ȥǶ���Y����������ȥǶ������̣�Yint-Sint�CZ�CY�CS���õ�����
%            �ź�ģ�͵�S�������ɺ���GWOmod()ʵ��)��Ȼ��������ʵ��ģ�͵�S�����Ƚ�
%            ������ڵ�����������������PSO�㷨�����Ż���������������ֱ���ﵽ
%            ���������������õ������Ż���Ĳ���ֵ��-------[���Ż���������Ϊ��]
%            --------------------------------------------------------------
%            PSO�㷨�Ľ�������������Ӧ����Ȩ�ز���
%            --------------------------------------------------------------
% Update   : 2022-12-25@Haiyi Cai: original
%            2023-03-02@Yuhao Ren: ����һ�ֶ�̬����ӦPSO�Ľ��㷨
%                                  -----------------Comparison-------------
%                                  | Para. |  Original   |    Optimizatio |
%                                  ----------------------------------------
%                                  |�����ٶ�|iteration=80 |   iteration=30 |   
%                                  ----------------------------------------
%                                  |������ֵ|number=3~5   |    number=0~1  |
%                                  ----------------------------------------
% Attention: Copyright(C) 2022-2023 Ren Yuhao, all rights reserved.
% -------------------------------------------------------------------------
% Reference
% [1]. https://blog.csdn.net/qq_44589327/article/details/105371963
% [2]. ������,������.һ�ַ����Զ�̬����Ӧ����Ȩ��PSO�㷨[J].���������,2021,38(04)
%      :249-253+451.
% -------------------------------------------------------------------------
%% ��ջ���
clear;clc;close;
tic %��������ʱ����¼��������ʱ�䣩
%% PSO Parameter Set
c1=1.2;               %ѧϰ����
c2=1.2;               %ѧϰ����
Dimension=10;         %��ϲ�������
Size=20;              %�������ӹ�ģ��С
Tmax=40;              %����������
Vmaximum=20;          %��������ٶ�

%% ������Χ���ã�������
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
%% ������Χ���ã�������
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
%% ��ʼ�����ӵ�λ�����ٶ�
position=zeros(Dimension,Size);
velocity=zeros(Dimension,Size);
% �����ٶ����½�
vmax(1:Dimension)=Vmaximum;
vmin(1:Dimension)=-Vmaximum;

%����λ�ü���ϲ���������
xmax=[k1max,k2max,k3max,k4max,k5max,k6max,k7max,k8max,k9max,k10max];
xmin=[k1min,k2min,k3min,k4min,k5min,k6min,k7min,k8min,k9min,k10min];

[position,velocity]=Initial_position_velocity(Dimension,Size,xmax,xmin,vmax,vmin);

pbest_position=position;          %���ӵ���ʷ����λ�ã���ʼֵΪ���ӵ���ʼλ�ã��洢ÿ�����ӵ���ʷ����λ��
gbest_position=zeros(Dimension,1);%ȫ�����ŵ��Ǹ���������λ�ã���ʼֵ��Ϊ�ǵ�1������

for j=1:Size
    Pos=position(:,j);          %ȡ��j��10*1������j�����ӵ�λ��
    fz(j)=Fitness_Function(Pos);%�����j�����ӵ���Ӧֵ
end
[gbest_fitness,I]=min(fz);   %���������Ӧֵ����С���Ǹ���Ӧֵ������ø����ӵ�λ��
gbest_position=position(:,I);%ȡ��С��Ӧֵ���Ǹ����ӵ�λ�ã���I��

%% ��ʼѭ���ҵ����Ž�

w_start = 0.9; w_end = 0.4;
for itrtn=1:Tmax %��������1~Tmax
%% �Ľ���ʽ1��Original��
    disp(itrtn); %��ʾ ��x����
%     Weight=w_end+(w_start-w_end)*(Tmax-itrtn)/Tmax;
%     Weight=((0.95-0.4)/(1-Tmax))*(itrtn-1)+0.95;

%% �Ľ���ʽ2(����Ӧ����Ȩ��)
%         Weight=w_start-(w_start-w_end)*itrtn/Tmax;                  % ���Եݼ�����
%         Weight=w_end+(w_start-w_end)*rand;                        % �������
%         Weight=w_end*(w_start/w_end)^(sqrt(1-(itrtn/Tmax)^2));    % ָ���ݼ���ʽ1
%         Weight=w_end*(w_start/w_end)^(1-(itrtn/Tmax)^2);          % ָ���ݼ���ʽ2
%         Weight=w_end*(w_start/w_end)^(1-(itrtn/Tmax));            % ָ���ݼ���ʽ3
%% �Ľ���ʽ3(�����Զ�̬����Ӧ)-----%         
%% -------------------------------------------------------------begin
%     ��Ⱥ������ɢ�Ȳ��� 
    if itrtn == 1
        k = 1;
    elseif itrtn > 1
        k = std(fz); %��Ӧ��ֵ������׼��
    end
    b = 0.5; %��������[0,1]
    Weight = w_start + (w_end - w_start)*1/(1 + exp(-10*b*((2*itrtn)/(k*Tmax)-1)));
%% ---------------------------------------------------------------end
    r1=rand(1); %����һ�������(ֵΪ0~1) ��ͬ
    r2=rand(1);
    %�����ٶȸ���
    for i=1:Size
    velocity(:,i)=Weight*velocity(:,i)+c1*r1*(pbest_position(:,i)-position(:,i))+c2*r2*(gbest_position-position(:,i));  
    end
    %�����ٶȱ߽磨��������ٶȵ�������ٶȴ��棬С����С�ٶȵ�����С�ٶȴ��棩
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
    position=position+velocity;%λ�ø���
    %����λ�ñ߽�
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
        p_position=position(:,j);                 %ȡһ�����ӵ�λ��
        fitness_p(j)=Fitness_Function(p_position);%�����j��������Ӧ�ȵ�ֵ
     if fitness_p(j)<fz(j) %���ӵ���Ӧֵ���˶�֮ǰ����ӦֵҪ�ã�����ԭ������Ӧֵ
         pbest_position(:,j)=position(:,j);
         fz(j)=fitness_p(j);
     end
     if fitness_p(j)<gbest_fitness
         gbest_fitness=fitness_p(j);%��������ӱȵ�ǰȫ����Ӧ�ȵ�ֵ���ã������
     end
  end
  [gbest_fitness_new,I]=min(fz);          %���º���������ӵ���Ӧֵ��ȡ��С���Ǹ������������
   best_fitness(itrtn)=gbest_fitness_new; %��¼ÿһ���������Ӧֵ
   % Draw Process of Fitting------------------------------------------BEGIN
   figure(1);subplot(2,2,1);
   plot(best_fitness, 'b.-');
   title('������Ӧ�Ƚ�������','FontSize',12) 
   xlabel('��������','FontSize',12);
   ylabel('������Ӧֵ','FontSize',12);
   % -------------------------------------------------------------------END
   gbest_position=pbest_position(:,I);%�����Ӧֵ��Ӧ�ĸ�������λ��
   subplot(2,2,2);hold on
   plot(gbest_position,'rx');
   title('����λ�÷ֲ�','FontSize',12);
   xlabel('��ϲ���','FontSize',12);
   ylabel('����ֵ','FontSize',12);
  
end
%% ����������
subplot(2,2,3);
plot(gbest_position,'ro');
title('��������λ�ã��������ֵ��','FontSize',12);
xlabel('��ϲ���','FontSize',12);
ylabel('����ֵ','FontSize',12);
for n=1:10
    disp(['k',num2str(n),'��ϲ�������ֵ��',num2str(gbest_position(n))]);
end
disp(['������ӦֵΪ��',num2str(best_fitness(Tmax))]);
%% ��ȡ��ϲ�������ֵ �����ʽ
%���ɱ���������ƣ�m��n��
str1='��ϲ���ֵ'; str2='k';
m=10;n=1;
column_name=strcat(str1,num2str((1:n)'));
row_name=strcat(str2,num2str((1:m)'));

%�����ͼ
%set(figure(2),'position',[500 500 500 500]);
uitable(gcf,'Data',gbest_position,'Position',[320 10 200 200],'Columnname',column_name,'Rowname',row_name);
%%
toc
