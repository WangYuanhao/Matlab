function [x] = newton_method(func,initial_x,iters,tol,debug)

%updata formula
%   x = x - f(x)/f'(x)
%example
%   f(x) = x - cos(x)
%   [x] = newton_method('x-cos(x)',1,20,1e-5)

    if nargin == 4
        debug = 0;
    end
    
    df = diff(sym(func));
    old_x = initial_x;
    
    for i = 1:iters
        new_x = old_x - subs(sym(func),old_x)/subs(df,old_x);
        
        if debug == 1
            fprinf('In %d th iteration: ',i);
            display(new_x);
        end
        
        if abs(old_x - new_x) < tol
            x = new_x;
            
            if debug == 1
                fprinf('After %d iterations, newoton method converged.\n');
                fprinf('The solution is: \n');
                display(x);
            end
            
            break;
        end
        old_x = new_x;
    end
    
    if i == iters
        x = NaN;
        fprintf('The newton method cannot converge within %d iterations with tolerance %f',iters,tol);
        
    end
        
end
