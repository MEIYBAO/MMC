clc,clear
data=readmatrix('Q1data.xlsx');
data=data(data(:,1)==28,2:end);
data1=data(data(:,1)>=11&data(:,1)<14,:);
data2=data(data(:,1)>=14&data(:,1)<17,:);
data3=data(data(:,1)>=17&data(:,1)<20,:);
data4=data(data(:,1)>=20&data(:,1)<23,:);

figure
scatter(data1(:,2),data1(:,3),50,'r','filled')
xlabel('孕妇BMI/（kg/m^2）','Interpreter','tex')
ylabel('Y染色体浓度/（%）')
writematrix(data1,'BMI27-30.xlsx')
grid on

figure
scatter(data2(:,2),data2(:,3),50,'b','filled')
xlabel('孕妇BMI/（kg/m^2）','Interpreter','tex')
ylabel('Y染色体浓度/（%）')
writematrix(data2,'BMI30-33.xlsx')
grid on

figure
scatter(data3(:,2),data3(:,3),50,[0.9, 0.4, 0],'filled')
xlabel('孕妇BMI/（kg/m^2）','Interpreter','tex')
ylabel('Y染色体浓度/（%）')
writematrix(data3,'BMI33-36.xlsx')
grid on

figure
scatter(data4(:,2),data4(:,3),50,[0, 0.7, 0.9],'filled')
xlabel('孕妇BMI/（kg/m^2）','Interpreter','tex')
ylabel('Y染色体浓度/（%）')
writematrix(data4,'BMI36-39.xlsx')
grid on