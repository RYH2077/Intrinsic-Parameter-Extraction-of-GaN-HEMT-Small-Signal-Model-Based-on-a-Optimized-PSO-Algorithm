%% 表格数据
data_row1=[68,68,86,43];
data_row2=[48,15,37,25];
data=[data_row1;repmat(data_row2,12,1)];

%% 生成表格行列名称，m行n列
str1='气旋';str2='TC';
m=13;n=4;
column_name=strcat(str1,num2str((1:n)'));
row_name=strcat(str2,num2str((1:m)'));

%% 表格作图
set(figure(1),'position',[100 100 300 300]);
uitable(gcf,'Data',data,'Position',[100 10 200 200],'Columnname',column_name,'Rowname',row_name);
