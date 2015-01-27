function [Q,R] = householderQR(A)
% Implement householder QR factorization
% Dependencies:
%   householderTrans.m - [nu,beta] = householderTrans(x).
 
    [m,n] = size(A);
    Q = eye(m);
    for j = 1:n
        if j == m
            break;
        end
        [nu,beta] = householderTrans(A(j:m,j));
        H = eye(m);
        H(j:m,j:m) = eye(m-j+1) - (beta*nu)*nu';
        
        A = H*A;
        Q = Q*H;     
    end
    R = A;
end

