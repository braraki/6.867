function plot_analysis(grad, f, solution, test_name, func_name )

test_values = [];
error = [];
results = [];
norms = {};
step_nums = [];
for i = 1:10
    if strcmp(test_name, 'initial x')
        init_x = [solution(1)-exp(i-5); solution(2)];
    else
        init_x = [solution(1) + 5; solution(2) + 5];
    end
    if strcmp(test_name, 'step_size')
        step_size = 10/10^i;
    else
        step_size = 0.01;
    end
    if strcmp(test_name, 'convergence')
        precision = 10/10^i;
    else
        precision = 0.00001;
    end
    
    if strcmp(test_name, 'initial x')
        test_value = norm(init_x - solution);
    elseif strcmp(test_name, 'step_size')
        test_value = step_size;
    elseif strcmp(test_name, 'convergence')
        test_value = precision;
    end
    test_values = [test_values; test_value];

    [result, grad_norm, steps, gX, gY, gZ] = GradientDescent.grad_descent(grad, f, init_x, step_size, precision);
    results = [results; result'];
    error = [error; norm(solution - result)];
    norms{i} = grad_norm;
    step_nums = [step_nums; steps];
end

directory_name = '/home/brandon/classes/6.867/pset1/solutions/P1/images/1_1/';

if strcmp(test_name, 'initial x')
    x_label = 'distance of initial x from minimum';
elseif strcmp(test_name, 'step_size')
    x_label = 'step size';
elseif strcmp(test_name, 'convergence')
    x_label = 'convergence criterion';
end

figure
set(gcf, 'Color', 'w');
if strcmp(test_name, 'initial x')
    plot(test_values, error, 'LineWidth', 4);
else
    loglog(test_values, error, 'LineWidth', 4);
end
xlabel(x_label)
ylabel('error')
title([x_label ' vs. error for ' func_name])

export_fig([directory_name func_name '_' test_name '_error.png'])

figure
set(gcf, 'Color', 'w');
if strcmp(test_name, 'initial x')
    plot(test_values, step_nums, 'LineWidth', 4);
else
    semilogx(test_values, step_nums, 'LineWidth', 4);
end
xlabel(x_label)
ylabel('iterations')
title([x_label ' vs. iterations for ' func_name])
export_fig([directory_name func_name '_' test_name '_iterations.png'])

figure
set(gcf, 'Color', 'w');
semilogy(norms{3}, 'LineWidth', 4)
hold on
semilogy(norms{4}, 'LineWidth', 4)
semilogy(norms{5}, 'LineWidth', 4)
hold off
legend([x_label ' = ' num2str(test_values(3))],... 
       [x_label ' = ' num2str(test_values(4))], ...
       [x_label ' = ' num2str(test_values(5))]);
xlabel('iteration number')
ylabel('gradient norm')
title([x_label ' vs. gradient norm for ' func_name])
export_fig([directory_name func_name test_name '_norm.png'])

end

