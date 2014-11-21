function [x] = partialpivotingGaussel(A,b)
% solve the system Ax=b using Gaussian elimination with
%scaled partial pivoting
    n = length(b);
    x = zeros(n,1);
    fprintf('\n');
    disp('  The augmented matrix is=')
    augm = [A b]
    for i = 1:n
        d(i) = i;
        smax = 0;
        for j = 1:n
            smax = max(smax,abs(A(i,j)));
        end
        c(i) = smax;
    end
    for k = 1:n-1
        rmax = 0;
        for i = k:n
            R = abs(A(d(i),k))/c(d(i));
            if (R>rmax)
                j = i;
                rmax = R;
            end
        end
        dk = d(j);
        d(j) = d(k);
        d(k) = dk;
        for i = k+1:n
            m = A(d(i),k)/A(dk,k);
            for j = k+1:n
                A(d(i),j) = A(d(i),j) - m*A(dk,j);
            end
            A(d(i),k) = m;
        end
  
    end
    for k = 1:n-1
        for i = k+1:n
            b(d(i)) = b(d(i)) - b(d(k))*A(d(i),k);
        end
    end
    x(n) = b(d(n))/A(d(n),n);
    for i = n-1:-1:1
        S = b(d(i));
        for j = i+1:n
            S = S - A(d(i),j)*x(j);
        end
        x(i) = S/A(d(i),i);
    end
    A
    disp('  The scale vecotr=')
    c
    disp('  The index vector=')
    d
    fprintf('\n');
    disp('  The transformed upper triangular augmented matrix C is =')
    fprintf('\n')
    for i = 1:n
        M(i,:) = A(d(i),:);
    end
    for i = 1:n
        for j = 1:n
            if(j<i) M(i,j) = 0;
            end
        end
    end
    for i = 1:n
        A(i,:) = M(d(i),:);
    end
    C = [A b]
    fprintf('\n');
    disp('  The vector solution is =')
    x
end
