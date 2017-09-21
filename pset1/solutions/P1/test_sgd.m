% code for P1 3b

[X, Y] = loadFittingDataP1;

precision = 0.0001;
cur_theta = zeros(10, 1);
previous_step_size = 100;
step_num = 0;
%% gradient descent
while previous_step_size > precision
    i = mod(step_num, size(X, 1)) + 1;
    x = X(i, :);
    y = Y(i);    

    grad = @(theta) GradientDescent.grad_sgd_J(x, y, theta);
    [ cur_theta, previous_step_size ] = GradientDescent.sgd( grad, cur_theta, i );
    cur_theta;
    step_num = step_num + 1;
end

true_theta = inv(X'*X)*X'*Y;

true_error = sum(X*true_theta -Y);

norm(cur_theta - true_theta)