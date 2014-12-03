function [x]=gaussSeidel(A,b,iters,initialx,tol,debug)
    %Solve linear system Ax = b by using Gauss-Seidel method,this method
    %converges faster than Jacobi method.
    %matrix form
    %   $ (D+L)*x^{(k)} = -U*x^{(k-1)} + b $
    %iteration form
    % 
    if nargin < 5
        error('Not enough arguments')
    end
    if nargin == 5
        debug = 0;
    end
    n = length(b);
   % x = zeros(n,iters); % This will ask for more memory
   
    x = initialx;
    newX = zeros(n,1);
    for k = 1:iters
        %x(1,k) = (b(1)-A(1,2:end)*x(2:end,k-1))/A(1,1);
        newX(1) = (b(1)-A(1,2:end)*x(2:end))/A(1,1);
        for i = 2:n
            %x(i,k) = (b(i)-A(i,1:i-1)*x(1:i-1,k)- ...
            %    A(i,i+1:end)*x(i+1:end,k-1))/A(i,i); 
            newX(i) = (b(i)-A(i,1:i-1)*newX(1:i-1)- ...
                A(i,i+1:end)*x(i+1:end))/A(i,i); 
        end
        
        if debug == 1
            fprintf('In %d th iteration,the solution is:\n',k);
            disp(newX);
        end
        
        if norm(x-newX) < tol
            x = newX;
            
            if debug == 1
                fprintf('After %d iterations,Gauss-Seidel method converged.\n',k);
                fprintf('The solution is:\n');
                disp(x);
            end
            
            break
        end
        x = newX;
    end
    
    if k == iters
        x = NaN;
        fprintf('The Gauss-Seidel method cannot converge within %d iterations using tolerance: %f.\n',iters,tol)
    end
end