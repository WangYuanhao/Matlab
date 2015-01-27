function [A,V] = jacobiMethod(A,tol,options)

% Computing eigenvalues and eigenvector of symmetric matrix using classical
%  Jacobi method or cyclic-by row Jacobi method. 

% Reture :: A - approximated diagonal matrix of orginal A.
%           V - normalized eigenvectors of original A.            
% Referrence:
%       G. H. Golub and C. F. Van Loan, Matrix Computation, 4th ed: page 478 -
%       480.
% Dependencies: 
%       symSchur2.m -----------------[c,s] = symSchur2(A,p,q)
% Example
%       A = [2 -1 0;-1 2 -1;0 -1 2];
%       options.debug = 1;
%       options.maxIters = 10;
%       options.cyclic = 1;
%       [A,V] = classicalJacobi(A,1e-2,options)
   
    if ~isfield(options,'debug')
        debug = 0;
    else
        debug = options.debug;
    end
    
    if ~isfield(options,'maxIters')
        maxIters = 100;
    else
        maxIters = options.maxIters;
    end
    
    if ~isfield(options,'cyclic')
        cyclic = 1;
    else
        cyclic = options.cyclic;
    end
    
    n = size(A,1);
    V = eye(n);
    fnormA = norm(A,'fro'); 
   
    delta = tol*fnormA;
    offA = sqrt(fnormA^2 - sum(diag(A).^2));
    
 
    iters = 1;
    
    if cyclic == 0
        while offA > delta

            if iters > maxIters
                fprintf('Jacobi method cannot converge within %d iterations with tolerance %f.\n',maxIters,tol);
                break;
            end
            %colMaxValue: max value of each column.
            [colMaxValue,p] = max(abs(A-diag(diag(A))));
            [~,q] = max(colMaxValue);
            p = p(q);

            [c,s] = symSchur2(A,p,q);

            J = eye(n);
            J(p,p) = c;J(q,q) = c;J(p,q) = s;J(q,p) = -s;

            A = J'*A*J;
            V = V*J;
            if debug == 1
                fprintf('In %d th iteration: \n',iters);
                fprintf('Choose %d th row and %d th column.\n',p,q);
                fprintf('new A:\n')
                disp(A);
            end
            iters = iters + 1;

        end
        
    else
        while offA > delta

            if iters > maxIters
                fprintf('Jacobi method cannot converge within %d iterations with tolerance %f.\n',maxIters,tol);
                break;
            end
            %colMaxValue: max value of each column.
            for p = 1:(n-1)
                for q = (p+1):n

                    [c,s] = symSchur2(A,p,q);

                    J = eye(n);
                    J(p,p) = c;J(q,q) = c;J(p,q) = s;J(q,p) = -s;

                    A = J'*A*J;
                    V = V*J;
                    if debug == 1
                        fprintf('In %d th iteration: \n',iters);
                        fprintf('Choose %d th row and %d th column.\n',p,q);
                        fprintf('new A:\n')
                        disp(A);
                    end
                end
            end
            iters = iters + 1;
        end
    end
end