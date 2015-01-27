function [dividiffCoeff] = newtonInterpolation(x,y)
% Return divided difference coefficients of Newton divided difference 
% interpolation
% exmaple
% x = [0 1 3 4];
% y = [0 2 8 9];
% [dividiffCoeff] = newtonInterpolation(x,y)
  numRecords = length(x);
  D0 = y;
  dividiffCoeff = zeros(numRecords,1);
  dividiffCoeff(1) = D0(1);
 for i = (numRecords-1):-1:1
     D = zeros(i,1);
     for k = 1:i
         D(k) = (D0(k+1)-D0(k))/(x(k+numRecords-i)-x(k));
         %disp(D(k))
%          if (k+i-numRecords) > numRecords
%              break;
%          end
     end
     %disp(D)
     dividiffCoeff(numRecords - i+1) = D(1);
     D0 = D;
 end
end
    
