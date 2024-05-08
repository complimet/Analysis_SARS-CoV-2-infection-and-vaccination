function [zscores,coeff,var_matrix]=gpcaplot(x,y)
%ploting gPCA projection for input data x with labels in y 
% labels have to be numeric
%copyright, MCuperlovicCulf, Ottawa, 2024

[~,I]=sort(y);
x=x(I,:);
y=y(I);
% batch matrix B - nxb matrix - n samples, b batch groups bik=1 if sample i
% is in batch k,  0otherwise
batches=unique(y);
B(1:numel(y),1:numel(batches))=0;
for i=1:numel(y)
    for j=1:numel(batches)
        if y(i)==batches(j)
        B(i,j)=1;
        end
    end
end

tempx=B'*x;

[coeff,zscores,pcvars,mu]=pca(normalize(tempx));
percent_explained = 100*pcvars/sum(pcvars);

% loadings coeff
var_matrix=tempx*coeff;

figure
figure('Renderer', 'painters', 'Position', [10 10 900 600])
C = {'b','r','g','y'};

gscatter(zscores(:,1),zscores(:,2), batches,'brgy');
hold on
%gscatter(zscores(:,1),zscores(:,2), y,'o','MarkerSize',8);


xlabel(['PC1 ',num2str(percent_explained(1)),'%'])
ylabel(['PC2 ',num2str(percent_explained(2)),'%'])
title("gPCA");
%text(zscores(:,1),zscores(:,2),y,'brgy');
fontname("Arial")
figure
figure('Renderer', 'painters', 'Position', [10 10 900 600])
uniquegroups=unique(batches);
subplot(1,2,1);
for i=1:numel(uniquegroups)

h=histfit(zscores(strcmp(batches,uniquegroups(i)),1),[],'kernel');

h(2).Color = C{i-4*fix((i-1)/4)};
delete(h(1))

ylabel("distribution");
xlabel("PC1");

% ylim([0 inf]) 
hold on
end

subplot(1,2,2);
for i=1:numel(uniquegroups)
h=histfit(zscores(strcmp(batches,uniquegroups(i)),2),[],'kernel');

h(2).Color = C{i-4*fix((i-1)/4)};
delete(h(1))

ylabel("distribution");
xlabel("PC2");
hold on
end
end