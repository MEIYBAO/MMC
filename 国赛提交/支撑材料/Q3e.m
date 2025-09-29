clc,clear
cp=readmatrix('Q3datae.xlsx');
cp=cp(:,2);
% cp(cp(:,1)<=25)=cp(cp(:,1)<=25)+9;

rd=1000;
figure
color={[214 207 103]/256,[104 180 206]/256,[249 156 66]/256,[70 96 173]/256,[0 0 139]/256};
for i=1:5
    scatter(1:rd,cp(i:5:end),10,color{i},'filled')
    hold on

    clevel=0.95;
    a=1-clevel;
    fd=rd-1;
    t=tinv(1-a/2,fd);
    me=mean(cp(i:5:end));
    SE=me/sqrt(rd);
    CI=t*SE;
    lb=me-CI;
    ub=me+CI;

    h=fill([1,rd,rd,1],[ub,ub,lb,lb],color{i},'LineStyle','none');
    set(h,'facealpha',0.2);

    plot(1:rd,ones(1,rd)*me,'Color',color{i},'LineWidth',2)
end
xlabel('次数')
ylabel('BMI中心')
ylim([28,40])

figure
boxm=[];
for i=1:5
    boxm=[boxm,cp(i:5:end)];
end
h=boxchart(boxm);
h.MarkerStyle='.';
h.MarkerColor=[243 222 104]/256;
h.BoxFaceColor=[243 222 104]/256;
xlabel('组别')
ylabel('BMI中心')

v=0;
for i=1:5
    v=v+var(cp(i:5:end));
end
v=v/5;