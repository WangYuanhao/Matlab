function [Q,R] = givensQR2(A)
% implement Givens QR method
% Dependencies:
%       givens.m - [c,s] = givens(a,b).
    [m,n] = size(A);
    Q = eye(m);
    
    for j = 1:n
        for i = m:-1:j+1;
          
            G = eye(m);
           
            [c,s] = givensRotation(A(i-1,j),A(i,j));
            A(i-1:i,j:n) = [c s;-s c]'*A(i-1:i,j:n);
           
            G(i-1,i-1) = c; G(i-1,i) = s;
            G(i,i-1) = -s;G(i,i) =c;
          
            Q = Q*G;
          
        end
    end
    R = A;
end