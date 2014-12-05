close all;clc;clear;
n = length(1:2:1000);
maxRecord = zeros(n,1);
minRecord = zeros(n,1);
maxPossibleValue = zeros(n,1);
count = 1;
t = 1;
%figure('position',[30 30 211 466])
string = 'low histogram of distance for different dimension_';
for i = 1:2:1000
    M = round(rand(100,i));
    %M = mvnrnd(zeros(i,1),diag(ones(i,1)),100);
    D = pdist(M);
    maxRecord(count) = max(D);
    minRecord(count) = min(D);
    maxPossibleValue(count) = norm(ones(i,1));
    
    %stdD = (D - min(D))./(max(D)-min(D));
    %subplot(2,1,t)
    %hist(D);
    %str = strcat('dimension N=',num2str(i));
    %title(str);
%     if t  == 2 
%       
%         saveas(gcf,strcat(string,num2str(10+count),'.png'));
%         t = 1;
%         clf;
%     else
%         t = t + 1;
%     end
    count = count + 1;
end
% plot(1:2:1000,maxRecord,'r.-','MarkerFaceColor','r');
% hold on 
% plot(1:2:1000,minRecord,'b*-','MarkerFaceColor','b');
%figure(2)
plot(1:2:200,maxRecord(1:length(1:2:200)),'r.-','MarkerFaceColor','r');
hold on 
plot(1:2:200,minRecord((1:length(1:2:200))),'b*-','MarkerFaceColor','b');
plot(1:2:200,maxPossibleValue((1:length(1:2:200))),'gv-','MarkerFaceColor','g','MarkerSize',3);
title('Distance of Random 0-1 Sequences','fontsize',11);
xlabel('Dimension N','fontsize',11);
ylabel('Euclidean Distance','fontsize',11);
h=legend('max distance of points','min distance of points','maximun possible distance', ...
    'Location','NorthWest');
set(h,'fontsize',11);
legend('boxoff');