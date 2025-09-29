clc,clear
data=readmatrix('Q1data.xlsx');
data=data(:,[1,4]);
group=findgroups(data(:,1));
mean=splitapply(@mean,data(:,2),group);
ug=unique(data(:,1));

figure
scatter(ug,mean,50,'r','filled')
writematrix([ug,mean],'Q1BMI.xlsx')
xlabel('年龄')
ylabel('Y染色体浓度/（%）')
writematrix([ug,mean],'age.xlsx')
grid on

% clc,clear
% data=readmatrix('Q1data.xlsx');
% data=data(data(:,4)>=0.04,:);
% data=data(:,[2,3]);
% figure
% scatter(data(:,1),data(:,2),50,'b','filled')