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

x=[];
alpha=0.04;
curid=0;
for i=1:size(data,1)
    if data(i,1)==curid+1
        curid=curid+1;
    end
    if data(i,1)==curid && data(i,4)>=alpha
        curid=curid+1;
        x=[x;data(i,[2,3])];
    end
end

lb=25;
rb=48;
k=5;
[index,c]=kmeans(x,k);
c=sortrows(c,2);
group=zeros(k,3);
group(1,:)=[lb,round((c(1,2)+c(2,2))/2),c(1,1)];
for i=2:k-1
    group(i,:)=[round((c(i-1,2)+c(i,2))/2),round((c(i,2)+c(i+1,2))/2),c(i,1)];
end
group(k,:)=[round((c(k-1,2)+c(k,2))/2),rb,c(k,1)];

weight=[2,4,6,8];
week=[12,27];

fval=zeros(k,2);
for i=1:size(data,1)
    for j=1:k
        if data(i,3)>=group(j,1) && data(i,3)<group(j,2)
            ind=j;
            break;
        end
    end
    if data(i,4)<alpha
        pos=2;
    elseif group(ind,3)<=week(1)
        pos=1;
    elseif group(ind,3)>week(1) && group(ind,3)<=week(2)
        pos=3;
    else
        pos=4;
    end
    fval(ind,1)=fval(ind,1)+weight(pos);
    fval(ind,2)=fval(ind,2)+1;
end

f=fval(:,1)./fval(:,2);
f(isnan(f))=0;
fmean=mean(f);
fvar=var(f);