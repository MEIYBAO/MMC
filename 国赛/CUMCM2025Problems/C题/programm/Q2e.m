clc,clear
data=readcell('附件.xlsx');
colind=[2,3,10,11,22];
data=data(2:end,colind);
for i=1:size(data,1)
    converted_str = strrep(data{i,3}, 'w', '*7');
    data{i,3}=eval(converted_str)/7;
    str=regexprep(data{i,1},'[^0-9]','');
    data{i,1}=str2double(str);
end
data=cell2mat(data);
data=data(:,[1,3,4,5]);

k=5;
alpha=0.04;
rd=1000;
back=data(:,4);
cp=zeros(k*rd,2);
for ri=1:rd
    x=[];
    curid=0;
    data(:,4)=back+normrnd(0,0.1,size(data,1),1);
    for i=1:size(data,1)
        if data(i,1)==curid+1
            curid=curid+1;
        end
        if data(i,1)==curid && data(i,4)>=alpha
            curid=curid+1;
            x=[x;data(i,[2,3])];
        end
    end
    [index,c]=kmeans(x,k);
    c=sortrows(c,2);
    c=[c(:,2),c(:,1)];
    cp((ri-1)*k+1:ri*k,:)=c;
end
cp(cp(:,1)<=25)=cp(cp(:,1)<=25)+9;

figure
color={[214 207 103]/256,[104 180 206]/256,[249 156 66]/256,[70 96 173]/256,[0 0 139]/256};
for i=1:5
    scatter(1:rd,cp(i:5:end,1),10,color{i},'filled')
    hold on

    clevel=0.95;
    a=1-clevel;
    fd=rd-1;
    t=tinv(1-a/2,fd);
    me=mean(cp(i:5:end,1));
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
    boxm=[boxm,cp(i:5:end,1)];
end
h=boxchart(boxm);
h.MarkerStyle='.';
h.MarkerColor=[165 198 130]/256;
h.BoxFaceColor=[165 198 130]/256;
xlabel('组别')
ylabel('BMI中心')

v=0;
for i=1:5
    v=v+var(cp(i:5:end,1));
end
v=v/5;