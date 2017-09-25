directory_name = '/home/brandon/classes/6.867/pset1/solutions/P1/images/1_3/';

[X, y] = loadFittingDataP1;

true_theta = inv(X'*X)*X'*y;
true_error = norm(X*true_theta -y);


%% BATCH
grad = @(theta) GradientDescent.grad_batch_J(X, y, theta);
f = @(theta) GradientDescent.batch_J(X, y, theta);
init_x = zeros(size(X(1,:)))';
step_size = 0.0000001;
precision = 0.0000001;
% precision = 0.0001;

[result, grad_norm, steps, gX, gY, gZ] = GradientDescent.grad_descent(grad, f, init_x, step_size, precision);

batch_error = norm(X*result - y);

batch_theta_error = norm(result - true_theta);

batch_steps = steps * size(X, 1);

%% SGD
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

sgd_error = norm(X*cur_theta - Y);
sgd_theta_error = norm(cur_theta - true_theta);

sgd_steps = step_num;

figure
set(gcf, 'Color', 'w');
bar([true_error batch_error sgd_error], 0.4)
labels={'normal equations error'; 'batch error'; 'sgd error' };
set(gca,'xticklabel',labels)
title('gradient descent error')
axis([-inf inf 90 93])
export_fig([directory_name 'error.png'])

figure
set(gcf, 'Color', 'w');
bar([batch_theta_error sgd_theta_error], 0.4)
labels={'batch theta difference'; 'sgd theta difference' };
set(gca,'xticklabel',labels)
title({'difference between gradient descent', 'theta and normal equations theta'})
export_fig([directory_name 'theta error.png'])

figure
set(gcf, 'Color', 'w');
bar([batch_steps sgd_steps], 0.4)
labels={'batch steps'; 'sgd steps' };
set(gca,'xticklabel',labels)
title({'number of steps of gradient descent'})
export_fig([directory_name 'steps.png'])