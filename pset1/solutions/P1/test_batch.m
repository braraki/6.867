% code for P1 3a

[X, y] = loadFittingDataP1;

%% gradient descent
grad = @(theta) GradientDescent.grad_batch_J(X, y, theta);
f = @(theta) GradientDescent.batch_J(X, y, theta);
init_x = zeros(size(X(1,:)))';
step_size = 0.0000001;
precision = 0.00000001;
precision = 0.0001;

[result, grad_norm, steps, gX, gY, gZ] = GradientDescent.grad_descent(grad, f, init_x, step_size, precision);

error = sum(X*result - y);

true_theta = inv(X'*X)*X'*y;

true_error = sum(X*true_theta -y);

result - true_theta