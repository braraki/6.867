[gaussMean, gaussCov, quadBowlA, quadBowlb] = loadParametersP1;

params{1} = quadBowlA;
params{2} = quadBowlb;

%% gradient descent
grad = @(x) GradientDescent.grad_quad(x, params);
f = @(x) GradientDescent.quad(x, params);
init_x = [18; 18];
step_size = 0.01;
precision = 0.00001;

[result, grad_norm, steps, gX, gY, gZ] = GradientDescent.grad_descent(grad, f, init_x, step_size, precision);

%% compare analytic and numeric gradients at the points of gradient descent
ana_grad = [];
num_grad = [];
h = 0.01;
for i = 1:length(gX)
    x = [gX(i); gY(i)];
    num_grad = [num_grad; GradientDescent.central_diff(x, f, h)'];
    ana_grad = [ana_grad; grad(x)'];
end
grad_diffs = num_grad - ana_grad;

%% create plot of the gaussian
lim = 10;
quad_zero = inv(quadBowlA)*quadBowlb;
[X, Y] = meshgrid(-lim+quad_zero(1):0.5:lim+quad_zero(1), -lim+quad_zero(2):0.5:lim+quad_zero(2));
for i = 1:length(X)
    for j = 1:length(Y)
        Z(i, j) = GradientDescent.quad([X(1,i); Y(j,1)], params);
    end
end

figure
title('gradient descent on the quadratic bowl')
xlabel('x')
ylabel('y')
set(gcf, 'Color', 'w');
hold on
s = surf(X,Y,Z, 'FaceAlpha', 0.5, 'EdgeColor', 'none');
scatter3(gX,gY,gZ, 40,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[0 .75 .75]);
xlabel('x')
ylabel('y')
hold off
view(34,12)
directory_name = '/home/brandon/classes/6.867/pset1/solutions/P1/images/1_1/';
export_fig([directory_name 'gradient_descent_quad.png']);