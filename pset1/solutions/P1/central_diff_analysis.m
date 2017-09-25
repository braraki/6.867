function [mean_error] = central_diff_analysis(grad, f, solution, func_name, h, normal_h )
directory_name = '/home/brandon/classes/6.867/pset1/solutions/P1/images/1_2/';
%% compare analytic and numeric gradients at the points of gradient descent
ana_grad = [];
num_grad = [];
lim=5;

X = [];
Y = [];
grad_error = [];
[X, Y] = meshgrid(solution(1)-lim:0.5:solution(1)+lim, solution(2)-lim:0.5:solution(2)+lim);
for i = 1:size(X, 1)
    for j = 1:size(X, 2)
        x = [X(1, i); Y(j, 1)];
        num_grad = GradientDescent.central_diff(x, f, h);
        ana_grad = grad(x);
        grad_error(i, j) = norm(num_grad - ana_grad);
    end
end

mean_error = mean(mean(grad_error));

figure
surf(X, Y, grad_error)
xlabel('x')
ylabel('y')
zlabel('error')
title({'error between numerical and analytic gradients', ['of ' func_name ' for step size h = ' num2str(normal_h)]})
export_fig([directory_name func_name '_' num2str(normal_h) '.png']);
end