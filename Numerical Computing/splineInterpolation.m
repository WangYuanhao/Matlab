 function [value] = splineInterpolation(x,y,point,opt)
% exmaple
% x = [0 0.2 0.4 0.6 0.8 1.0];
% y = [2.0 2.008 2.064 2.216 2.512 3.0];
%splineInterpolation(x,y,0.5,2)   
    if nargin == 3
        spl = 3;
    else
        spl = opt;
    end
    numRecords = length(x);
    count = length(point);
    value = zeros(count,1);
    
    if spl == 1
% liner spline
      for t = 1:count 
        for i = (numRecords-1):-1:1
            distance = point(t) - x(i);
            if distance >= 0
                break;
            end
        end
        slope = (y(i+1) - y(i))/(x(i+1)-x(i));
        value(t) = slope*distance + y(i);
      end
    end
    
    if spl == 2
% quadratic spline
        %numRecords = length(x);
        d = zeros(numRecords,1);
        for k = 2:numRecords
            d(k) = -d(k-1) + 2*(y(k) - y(k-1))/(x(k)-x(k-1));
        end
       for t = 1:count
            for i = (numRecords-1):-1:1
                distance = point(t) - x(i);
                if distance >= 0
                    break;
                end
            end
            value(t) = y(i) + d(i)*distance + distance^2*(d(i+1)-d(i))/(2*(x(i+1)-x(i)));
       end
    end
    
    if spl == 3
% cubic spline  
        %numRecords = length(x);
        dx = diff(x);
        a = y';
        u = ones(numRecords,1);
        v = zeros(numRecords,1);
        for i = 2:numRecords-1
            u(i) = 2*(dx(i)+dx(i-1));
            v(i) = 3*(a(i+1) - a(i))/dx(i) - 3*(a(i) - a(i-1))/dx(i-1) ;
        end
        A = diag(u) + diag([dx(1:end-1),0],-1)+diag([0,dx(2:end)],1);
        %disp(A);
        c = A\v;
        b = zeros(numRecords - 1,1);
        d = zeros(numRecords - 1,1);
        for j = 1:numRecords - 1
            b(j) = (a(j+1) - a(j))/dx(j) - dx(j)*(c(j+1)+2*c(j))/3;
            d(j) = (c(j+1) - c(j))/(3*dx(j));
        end
        coeffMat = [a(1:end-1),b,c(1:end-1),d];
       %disp(coeffMat);
        for t = 1:count
            for i = (numRecords-1):-1:1
                distance = point(t) - x(i);
                if distance >= 0
                    break;
                end
            end

            value(t) = coeffMat(i,1)+coeffMat(i,2)*distance+coeffMat(i,3)*distance^2+ ...
                coeffMat(i,4)*distance^3;
        end
    end
  
end