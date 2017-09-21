[gaussMean, gaussCov, quadBowlA, quadBowlb] = loadParametersP1;

params{1} = quadBowlA;
params{2} = quadBowlb;

%% gradient descent
grad = @(x) GradientDescent.grad_quad(x, params);
f = @(x) GradientDescent.quad(x, params);
solution = inv(quadBowlA)*quadBowlb;

plot_analysis(grad, f, solution, 'initial x', 'quadBowl')
plot_analysis(grad, f, solution, 'step_size', 'quadBowl')
plot_analysis(grad, f, solution, 'convergence', 'quadBowl')