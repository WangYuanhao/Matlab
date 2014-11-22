function [solution] = jacobiIterations(A,b,initialX,iters,tol,debug)
% solve linear system Ax = b with jacobi method
% example
% A = [7 -2 1 0;1 -9 3 -1;2 0 10 1;1 -1 1 6];
% b = [17 13 15 10]';
% x0 = [0 0 0 0]';
% [solu] = jacobiIterations(A,b,x0,100,1e-3,1);
    if nargin == 5
        debug = 0;
    end
    
    diagA = diag(diag(A));
    upperA = triu(A,1);
    lowerA = tril(A,-1);
    oldX = initialX;
    
    for i = 1:iters
        
        % update fomula
        newX = - diagA\(upperA + lowerA)*oldX + diagA\b;
        
        if debug == 1
            fprintf('During %d th iteration,the solution is:\n',i)
            disp(newX);
        end
        
        if abs(norm(newX) - norm(oldX)) < tol
            if debug == 1
                fprintf('The iteration is convergence.\n');
                fprintf('The solution of jacobi method is:\n');
                disp(newX);
            end
            solution = newX;
            break;
        end
        
        oldX = newX;
    end

    if i == 100
        fprintf('The solution cannot converge within %d setp.',iters);
        solution = NaN;
    end
end