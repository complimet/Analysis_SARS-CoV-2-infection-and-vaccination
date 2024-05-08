function number_of_fcm_clusters(x, N)
% determining number of clusters for k-means type clustering:
%For each k, calculate the total within-cluster sum of square (wss).
%Plot the curve of wss according to the number of clusters k.
%The location of a bend (knee) in the plot is generally considered as an indicator of the appropriate number of clusters.
%or
%For each k, calculate the average silhouette of observations (avg.sil).
%Plot the curve of avg.sil according to the number of clusters k.
%The location of the maximum is considered as the appropriate number of clusters.
%for Nc=10:5:20
% MCuperlovic-Culf, Ottawa, June 2023

clear totSum silSum
totSum=zeros(N,1);  % preallocate the result
silSum=zeros(N,1);  % preallocate the result
% 
 for Nc=1:N


%[centers,U] = fcm(x,Nc,1.3);
  [clust,~,sumd]=kmeans(x,Nc);
  totSum(Nc,1)=sum(sumd);
  silSum(Nc,1)=mean(silhouette(x,clust));
 end
figure
yyaxis("left")
plot(totSum)
yyaxis("right")
plot(silSum)