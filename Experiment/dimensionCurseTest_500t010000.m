clc;clear;
n = length(500:500:10000);
count = 1;
t = 1;
figure('position',[30 30 211 466])
string = 'Gaussian histogram of distance for different dimension_';
for i = 500:500:10000
    %M = rand(100,i)*100;
    M = mvnrnd(zeros(i,1),diag(ones(i,1)),100);
    D = pdist(M);
    stdD = (D - min(D))./(max(D)-min(D));
    subplot(2,1,t)
    hist(stdD);
    str = strcat('dimension N=',num2str(i));
    title(str);
    if t  == 2 
      
        saveas(gcf,strcat(string,num2str(count),'.png'));
        t = 1;
        clf;
    else
        t = t + 1;
    end
    count = count + 1;
end

