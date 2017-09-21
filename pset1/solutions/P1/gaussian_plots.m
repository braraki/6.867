[gaussMean, gaussCov, quadBowlA, quadBowlb] = loadParametersP1;

params{1} = gaussMean;
params{2} = gaussCov;

%% gradient descent
grad = @(x) GradientDescent.grad_gaussian(x, params);
f = @(x) GradientDescent.gaussian(x, params);
solution = gaussMean;

plot_analysis(grad, f, solution, 'initial x', 'gaussian')
plot_analysis(grad, f, solution, 'step_size', 'gaussian')
plot_analysis(grad, f, solution, 'convergence', 'gaussian')