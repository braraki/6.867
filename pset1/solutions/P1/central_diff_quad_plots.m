[gaussMean, gaussCov, quadBowlA, quadBowlb] = loadParametersP1;
directory_name = '/home/brandon/classes/6.867/pset1/solutions/P1/images/1_2/';
params{1} = quadBowlA;
params{2} = quadBowlb;

%% gradient descent
grad = @(x) GradientDescent.grad_quad(x, params);
f = @(y) GradientDescent.quad(y, params);
solution = inv(quadBowlA)*quadBowlb;
func_name = 'quadBowl';
means = [];
hs = [];
for i = 1:10
    h = 10^(i-10)
    hs = [h; hs];
    meanv = central_diff_analysis(grad, f, solution, func_name, vpa(h, 32), h);
    means = [meanv; means];
end

figure
loglog(hs, means, 'LineWidth', 4);
xlabel('h value');
ylabel('mean error');
title({'h value vs. mean error of', 'central difference approximation for quadBowl'});
export_fig([directory_name 'quadBowl_errors.png']);