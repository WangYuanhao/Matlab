function [selection] =  selecT(errorRate)
%errorRate is fitness value here.
%select two individuals every time,parents may be 
%selected repeatly
selection = zeros(2,1);
%compute cumulative fitness
cumulativeFit = cumsum(errorRate)./sum(errorRate);
for i = 1:2
    temp = cumulativeFit - rand();
    j=1;
    while temp(j)<0
        j  = j + 1;
    end
    selection(i) = j;
end
