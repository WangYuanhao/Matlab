clc;clear;
% Problem description:
% Fit a set of point data {x(i),y(i)}(x(i) = 0,0.1,...,2*pi) with the
% function f(x) a*cos(b*x) + b*sin(a*x) 

syms a b x y real;
f = (a*cos(b*x)+b*sin(a*x));
d = y - f;
Jsym = jacobian(d,[a b]);

% Generate the synthetic data from the curve function with some additional
% noise
a = 100;
b = 102;
x = [0,0.1:2*pi]';
y = a * cos(b*x) + b * sin(a*x);
y_input = y + 5*rand(length(x),1);

%initial guess for the parameters
a0 = 100.5;
b0 = 102.5;
y_init = a0 * cos(b0*x) + b0 * sin(a0*x);
Ndata = length(y_input);
% a and b are the paraters to be estimated
Nparams = 2;
% set # of iterations for the LM
n_iters = 100;
% set an inital value of the damping factor for the LM
lamda = 0.01;
updateJ = 1;
a_est = a0;
b_est = b0;
for it = 1:n_iters
    if updateJ == 1
        % Evalute the Jacobian matrix at the current
        J = zeros(Ndata,Nparams);
        for i = 1:length(x)
            J(i,:) = [-cos(b_est*x(i))-b_est*x(i)*cos(a_est*x(i)), ...
                a_est*x(i)*sin(b_est*x(i)) - sin(a_est*x(i))];
        end
        % Evalute the distance error at the current paramters
        y_est = a_est*cos(b_est*x) + b_est*sin(a_est*x);
        d = y_input - y_est;
        % compute the approxiamted Hessian matrix, J' is the transpose of J
        H = J'*J;
        % the first iteration: compute the total error
        if it == 1
            % dot product of vector
            e = dot(d,d);
        end
    end
    
    % Apply the damping facotr to the Hessian matrix
    H_lm = H + H*(lamda*eye(Nparams));
    
    % Compute the updated paramters
    dp = -inv(H_lm)*(J'*d(:));
    a_lm = a_est + dp(1);
    b_lm = b_est + dp(2);
    
    % Evalute the total distance error at the updated paramters
    y_est_lm = a_lm*cos(b_lm*x) + b_lm*sin(a_lm*x);
    d_lm = y_input - y_est_lm;
    e_lm = dot(d_lm,d_lm);
    
    % If the total distance error of the updated paramters is less than
    % the previous one then make the updated paramters to be the current
    % paramters and decrease the value of the damping factor
    if e_lm < e
        lamda = lamda / 10;
        a_est = a_lm;
        b_est = b_lm;
        e = e_lm;
        disp(e);
        updateJ = 1;
    % otherwise incearses the value of the daming factor
    else
        updateJ = 0;
        lamda = lamda * 10;
    end
end

