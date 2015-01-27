function [nu,beta] = householderTrans(x)
% x must be a column vecotor
    if size(x,2) > 1
        error('x must be a column vecotor!');
    end
    m = length(x);
    sigma = x(2:m)'*x(2:m);
    nu = [1;x(2:m)];
    if sigma == 0 && x(1) >= 0
        beta = 0;
    else
        if sigma == 0 && x(1) < 0
            beta = -2;
        else
            mu = sqrt(x(1)^2 + sigma);
            if x(1) <= 0
                nu(1) = x(1) - mu;
            else
                nu(1) = - sigma/(x(1) + mu);
            end
            beta = 2*nu(1)^2/(sigma + nu(1)^2);
            nu = nu/nu(1);
        end
    end
           
end