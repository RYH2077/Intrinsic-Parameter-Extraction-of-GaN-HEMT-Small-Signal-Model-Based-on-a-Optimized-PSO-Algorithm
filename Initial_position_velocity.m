function [Position,Velocity] = Initial_position_velocity(Dimension,Size,Xmax,Xmin,Vmax,Vmin)
  for i=1:Dimension
      Position(i,:)=Xmin(i)+(Xmax(i)-Xmin(i))*rand(1,Size); % ��������Χ�ڵ����λ�ã�rand(1,Size)���ڲ���һ��Size�и������
      Velocity(i,:)=Vmin(i)+(Vmax(i)-Vmin(i))*rand(1,Size);
  end
end
% ��������������������������������
% ��Ȩ����������ΪCSDN������Pyrs����ԭ�����£���ѭCC 4.0 BY-SA��ȨЭ�飬ת���븽��ԭ�ĳ������Ӽ���������
% ԭ�����ӣ�https://blog.csdn.net/qq_44589327/article/details/105371963

