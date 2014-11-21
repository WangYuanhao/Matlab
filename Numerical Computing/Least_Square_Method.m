clc;clear;
% fiting curve y = a*x^2 + b*x^2 + c
% a = A(1), b = A(2), c = A(3)
% least square solution AX = Y ,X = inv(A'*A)*A'*Y

Y = [10987 12321 12035]';
x = [98.65 99.75 101.54]';
X = [x.^2,x,ones(3,1)];
A = X'*X\X'*Y;
% A = inv(X'*X)*X'*Y

plot(x,Y,'bo','markerfacecolor','b');
hold on

xForFit = [95:0.01:102]';
yFiting =  [xForFit.^2,xForFit,ones(length(xForFit),1)]*A;

plot(xForFit,yFiting,'r-','LineWidth',2);

legend('original points','fiting curve','Location','NorthWest')

xMax = - A(2) / (2*A(1));
yMax = A(1)*xMax^2 + A(2)*xMax + A(3);
string = strcat('coordinates of max value point for fiting curve is', ...
    '(',num2str(xMax),',',num2str(yMax),')');

plot(xMax,yMax,'r^','markerfacecolor','r');

line([95,xMax],[yMax yMax],'LineStyle','-.','LineWidth',2);
line([xMax xMax],[-2000 yMax],'LineStyle','-.','LineWidth',2);

text(xMax - 2,yMax - 1000,string)