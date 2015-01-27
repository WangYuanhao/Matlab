clc;clear;
syms a b c x real
f = a*x^2 + b*x + c;
jacobianMatrix = jacobian(f,[a b c]);

% Generate synthetic data
a = 5;b = 2;c = 1;
x = (-3:0.1:3)';
initialY = a*x.^2 + b*x + c;
syntheticY = initialY + 5*rand(length(x),1);
plot(x,initialY,'bo-','MarkerFaceColor','b');
hold on
update = 1;
numParams = 3;
iters = 100;
numRecords = length(x);
tol = 1e-3;
gamma = 0.01;
alpha = 10;
a0 = 0 ; b0 = 0; c0 = 0;
for i = 1:iters
    if update == 1
        jacobianMat = zeros(numRecords,numParams);
        for k = 1:numRecords
            jacobianMat(k,:) = [x(k)^2, x(k), 1];
        end
        Y0 = a0*x.^2 + b0*x + c0;
        y = jacobianMat' * (Y0 - syntheticY);
        A = (jacobianMat)'*jacobianMat;
        if i == 1
            sqErrorGuess = sum((Y0 - syntheticY).^2);
        end
    end
    hatA = A + A*gamma*eye(numParams);
    
    temp = -inv(hatA)*y;
    a_lm = a0 + temp(1);
    b_lm = b0 + temp(2);
    c_lm = c0 + temp(3);
    lmY = a_lm*x.^2 + b_lm*x + c_lm;
   
    sqErrorLM = sum((lmY - syntheticY).^2);
    
%     if abs(sqErrorGuess - sqErrorLM) < tol
%         break
%     else
     if sqErrorGuess < sqErrorLM
        gamma = alpha * gamma;
        update = 0;
     else
        a0 = a_lm;
        b0 = b_lm;
        c0 = c_lm;
        sqeErrorGuess = sqErrorLM;
        gamma = gamma/alpha;
        update = 1;
     end
end
plot(x,lmY,'rs-','MarkerFaceColor','r');
    
