function  [x] = gaussel(A,b,debug)
%solve the linear system Ax=b using naive gaussian elimination
% A must be a square matrix
    if nargin == 2
        debug = 0;
    end
    n = length(b);
    augMatrix = [A b];
    for k = 1:n-1
        m = augMatrix(k+1:n,k)/augMatrix(k,k);
        augMatrix(k+1:n,k+1:n+1) = augMatrix(k+1:n,k+1:n+1) - m * augMatrix(k,k+1:n+1);
        augMatrix(k+1:n,k) = 0;
        if debug == 1
            fprintf('\n');
            fprintf('  In step %d of Gaussian elimination the augmented matrix is =\n',k);
            augMatrix
        end
    end
    A = augMatrix(1:n,1:n);
    x = augMatrix(:,n+1);
    %backforward iteration
    for j = n:-1:2
        x(j) = x(j)/A(j,j);
        x(1:j-1) = x(1:j-1) - x(j).*A(1:j-1,j);
    end
    x(1,1) = x(1,1)/A(1,1);
end
    
% n = length(b);
% x = zeros(n,1);
% fprintf('\n');
% disp('  The augmented matrix is')
% augm = [A b]
% 
% for k = 1:n-1
%     for i = k+1:n
%         m = A(i,k)/A(k,k);
%         for j=k+1:n
%             A(i,j) = A(i,j) - m*A(k,j);
%         end
%         %A(i,k) = m;
%         b(i) = b(i) - m*b(k);
%      end
% end
% x(n) = b(n)/A(n,n);
% for i = n-1:-1:1
%     S = b(i);
%     for j = i+1:n
%         S = S - A(i,j)*x(j);
%     end
%     x(i) = S/A(i,i);
% end
% for i = 1:n
%     for j = 1:n
%         if(i>j) A(i,j) = 0;
%         end
%     end
% end
% fprintf('\n')
% disp('  The transformed upper triangular augmented matrix C is =')
% C = [A b]
% fprintf('\n')
% disp('  The vector sulotion is =')
% x
% 

