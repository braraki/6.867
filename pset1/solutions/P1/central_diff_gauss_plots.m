[gaussMean, gaussCov, quadBowlA, quadBowlb] = loadParametersP1;
directory_name = '/home/brandon/classes/6.867/pset1/solutions/P1/images/1_2/';
params{1} = gaussMean;
params{2} = gaussCov;

%% gradient descent
grad = @(x) GradientDescent.grad_gaussian(x, params);
f = @(x) GradientDescent.gaussian(x, params);
solution = gaussMean;
func_name = 'gaussian';
means = [];
hs = [];
for i = 1:11
    h = 10^(i-8);
    hs = [h; hs];
    meanv = central_diff_analysis(grad, f, solution, func_name, vpa(h,32), h);
    means = [meanv; means];
end

figure
loglog(hs, means, 'LineWidth', 4);
xlabel('h value');
ylabel('mean error');
title({'h value vs. mean error of', 'central difference approximation for gaussian'});
export_fig([directory_name 'gaussian_errors.png']);