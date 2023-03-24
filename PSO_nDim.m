%%---------------------------File Details------------------------------
 % Author  : Ren Yuhao
 % Github  : https://github.com/Ren-yuhao
 % File    : PSO_Optimization.m
 % Date    : 2023-01-02
 % Version : V1.0
 % Brief   : nά����PSO�Ż��㷨  
 % --------------------------Modify History----------------------------
 % 
 % --------------------------------------------------------------------
 % Attention: Copyright(C) 2022 Ren Yuhao, all rights reserved.
%%---------------------------------------------------------------------
%% ��ջ���
clc;clear all;close all;
%% Ŀ�꺯��
%    ���к���ΪRastrigin��������һ�����ֵ�ĺ�������0������ȡ��ȫ����Сֵ0
fun= @(X)(sum((X.^2-10*cos(2*pi*X)+10),1));

%% ������Ⱥ����
%   ��Ҫ��������
sizepop = 500;                    % ��ʼ��Ⱥ����
dim = 10;                          % �ռ�ά��
ger = 200;                       % ����������     
xlimit_max = 5.12*ones(dim,1);    % ����λ�ò�������(�������ʽ���Զ�ά)
xlimit_min = -5.12*ones(dim,1);
vlimit_max = 1*ones(dim,1);       % �����ٶ�����
vlimit_min = -1*ones(dim,1);
c_1 = 0.8;                        % ����Ȩ��
c_2 = 0.5;                        % ����ѧϰ����
c_3 = 0.5;                        % Ⱥ��ѧϰ���� 

%% ���ɳ�ʼ��Ⱥ
%  ����������ɳ�ʼ��Ⱥλ��
%  Ȼ��������ɳ�ʼ��Ⱥ�ٶ�
%  Ȼ���ʼ��������ʷ���λ�ã��Լ�������ʷ�����Ӧ��
%  Ȼ���ʼ��Ⱥ����ʷ���λ�ã��Լ�Ⱥ����ʷ�����Ӧ��
for i=1:dim
    for j=1:sizepop
        pop_x(i,j) = xlimit_min(i)+(xlimit_max(i) - xlimit_min(i))*rand;
        pop_v(i,j) = vlimit_min(i)+(vlimit_max(i) - vlimit_min(i))*rand;  % ��ʼ��Ⱥ���ٶ�
    end
end    
gbest = pop_x;                                % ÿ���������ʷ���λ��
fitness_gbest = fun(pop_x);                   % ÿ���������ʷ�����Ӧ��
zbest = pop_x(:,1);                           % ��Ⱥ����ʷ���λ��
fitness_zbest = fitness_gbest(1);             % ��Ⱥ����ʷ�����Ӧ��
for j=1:sizepop
    if fitness_gbest(j) < fitness_zbest       % �������Сֵ����Ϊ<; ��������ֵ����Ϊ>; 
        zbest = pop_x(:,j);
        fitness_zbest=fitness_gbest(j);
    end
end


%% ����Ⱥ����
%    �����ٶȲ����ٶȽ��б߽紦��    
%    ����λ�ò���λ�ý��б߽紦��
%    ��������Ӧ����
%    ��������Ⱥ��������λ�õ���Ӧ��
%    ����Ӧ���������ʷ�����Ӧ�����Ƚ�
%    ������ʷ�����Ӧ������Ⱥ��ʷ�����Ӧ�����Ƚ�
%    �ٴ�ѭ�������

iter = 1;                        %��������
record = zeros(ger, 1);          % ��¼��
while iter <= ger
    for j=1:sizepop
        %    �����ٶȲ����ٶȽ��б߽紦�� 
        pop_v(:,j)= c_1 * pop_v(:,j) + c_2*rand*(gbest(:,j)-pop_x(:,j))+c_3*rand*(zbest-pop_x(:,j));% �ٶȸ���
        for i=1:dim
            if  pop_v(i,j) > vlimit_max(i)
                pop_v(i,j) = vlimit_max(i);
            end
            if  pop_v(i,j) < vlimit_min(i)
                pop_v(i,j) = vlimit_min(i);
            end
        end
        
        %    ����λ�ò���λ�ý��б߽紦��
        pop_x(:,j) = pop_x(:,j) + pop_v(:,j);% λ�ø���
        for i=1:dim
            if  pop_x(i,j) > xlimit_max(i)
                pop_x(i,j) = xlimit_max(i);
            end
            if  pop_x(i,j) < xlimit_min(i)
                pop_x(i,j) = xlimit_min(i);
            end
        end
        
        %    ��������Ӧ����
        if rand > 0.85
            i=ceil(dim*rand);
            pop_x(i,j)=xlimit_min(i) + (xlimit_max(i) - xlimit_min(i)) * rand;
        end
  
        %    ��������Ⱥ��������λ�õ���Ӧ��

        fitness_pop(j) = fun(pop_x(:,j));                      % ��ǰ�������Ӧ��

        
        %    ����Ӧ���������ʷ�����Ӧ�����Ƚ�
        if fitness_pop(j) < fitness_gbest(j)       % �������Сֵ����Ϊ<; ��������ֵ����Ϊ>; 
            gbest(:,j) = pop_x(:,j);               % ���¸�����ʷ���λ��            
            fitness_gbest(j) = fitness_pop(j);     % ���¸�����ʷ�����Ӧ��
        end   
        
        %    ������ʷ�����Ӧ������Ⱥ��ʷ�����Ӧ�����Ƚ�
        if fitness_gbest(j) < fitness_zbest        % �������Сֵ����Ϊ<; ��������ֵ����Ϊ>; 
            zbest = gbest(:,j);                    % ����Ⱥ����ʷ���λ��  
            fitness_zbest=fitness_gbest(j);        % ����Ⱥ����ʷ�����Ӧ��  
        end    
    end
    
    record(iter) = fitness_zbest;%���ֵ��¼
    
    iter = iter+1;

end
%% ����������

plot(record);title('��������')
disp(['����ֵ��',num2str(fitness_zbest)]);
disp('����ȡֵ��');
disp(zbest);
