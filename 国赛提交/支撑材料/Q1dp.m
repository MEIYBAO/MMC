clc,clear
data=readcell('附件.xlsx');
colind=[3,10,11,22];
data=data(2:end,colind);
for i=1:size(data,1)
    converted_str = strrep(data{i,2}, 'w', '*7');
    data{i,2}=eval(converted_str)/7;
end
data=cell2mat(data);
writematrix(data,'Q1data.xlsx')