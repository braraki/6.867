[gaussMean, gaussCov, quadBowlA, quadBowlb] = loadParametersP1;

params{1} = gaussMean;
params{2} = gaussCov;

%% gradient descent
grad = @(x) GradientDescent.grad_gaussian(x, params);
f = @(x) GradientDescent.gaussian(x, params);
init_x = [5; 4];
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
[X, Y] = meshgrid(-lim+gaussMean(1):0.5:lim+gaussMean(1), -lim+gaussMean(2):0.5:lim+gaussMean(2));
for i = 1:length(X)
    for j = 1:length(Y)
        Z(i, j) = GradientDescent.gaussian([X(1,i); Y(j,1)], params);
    end
end

figure
title('gradient descent on the gaussian')
xlabel('x')
ylabel('y')
set(gcf, 'Color', 'w');
hold on
s = surf(X,Y,Z, 'FaceAlpha', 0.5, 'EdgeColor', 'none');
scatter3(gX,gY,gZ, 40,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[0 .75 .75]);
hold off
view(26,23)
directory_name = '/home/brandon/classes/6.867/pset1/solutions/P1/images/1_1/';
export_fig([directory_name 'gradient_descent_gaussian.png']);