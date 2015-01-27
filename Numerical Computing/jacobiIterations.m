function [solution] = jacobiIterations(A,y,initialX,iters,tol,options)
% solve linear system Ax = y with jacobi method
% example
% A = [7 -2 1 0;1 -9 3 -1;2 0 10 1;1 -1 1 6];
% y = [17 13 15 10]';
% x0 = [0 0 0 0]';
% options.debug = 0;
% options.relaxation = 0.8;
% [solu] = jacobiIterations(A,y,x0,100,1e-3,options);
    
    if ~isfield(options,'debug')
        debug = 0;
    else
        debug = options.debug;
    end
    
   
    if ~isfield(options,'relaxation')
        omega = 1;
    %using relaxation method
    else
        omega = options.relaxation;
    end
    
    diagA = diag(diag(A));
    upperA = triu(A,1);
    lowerA = tril(A,-1);
    oldX = initialX;
    
    for i = 1:iters
        
        % update fomula
       newX = - omega*diagA\(upperA + lowerA)*oldX + omega*diagA\y + ...
           (1-omega)*oldX;
        %newX = oldX + omega*diagA*(y - A*oldX);
        
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

    if i == iters
        fprintf('The solution cannot converge within %d setp\n',iters);
        solution = NaN;
    end
end