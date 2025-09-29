clc,clear
data=readmatrix('Q1data.xlsx');
data=data(data(:,1)==28,2:end);
data1=data(data(:,2)>=27&data(:,2)<30,:);
data2=data(data(:,2)>=30&data(:,2)<33,:);
data3=data(data(:,2)>=33&data(:,2)<36,:);
data4=data(data(:,2)>=36&data(:,2)<39,:);

figure
scatter(data1(:,1),data1(:,3),50,'r','filled')
xlabel('检测孕周/（周）')
ylabel('C')
writematrix(data1,' ga11-14.xlsx')
grid on

figure
scatter(data2(:,1),data2(:,3),50,'b','filled')
xlabel('检测孕周/（周）')
ylabel('Y染色体浓度/（%）')
writematrix(data2,' ga14-17.xlsx')
grid on

figure
scatter(data3(:,1),data3(:,3),50,[0.9, 0.4, 0],'filled')
xlabel('检测孕周/（周）')
ylabel('Y染色体浓度/（%）')
writematrix(data3,' ga17-20.xlsx')
grid on

figure
scatter(data4(:,1),data4(:,3),50,[0, 0.7, 0.9],'filled')
xlabel('检测孕周/（周）')
ylabel('Y染色体浓度/（%）')
writematrix(data4,' ga20-23.xlsx')
grid on