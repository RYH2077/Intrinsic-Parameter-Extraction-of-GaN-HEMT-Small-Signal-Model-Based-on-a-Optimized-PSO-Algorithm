function [Position,Velocity] = Initial_position_velocity(Dimension,Size,Xmax,Xmin,Vmax,Vmin)
  for i=1:Dimension
      Position(i,:)=Xmin(i)+(Xmax(i)-Xmin(i))*rand(1,Size); % 产生合理范围内的随机位置，rand(1,Size)用于产生一行Size列个随机数
      Velocity(i,:)=Vmin(i)+(Vmax(i)-Vmin(i))*rand(1,Size);
  end
end
% ————————————————
% 版权声明：本文为CSDN博主「Pyrs」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
% 原文链接：https://blog.csdn.net/qq_44589327/article/details/105371963

