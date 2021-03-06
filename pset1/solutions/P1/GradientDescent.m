classdef GradientDescent

    methods(Static)
        %% stochastic gradient descent
        function [ cur_theta, previous_step_size ] = sgd( grad, cur_theta, i )
            step_size = (500000 + i)^-0.95;

            prev_theta = cur_theta;
            gradient = grad(cur_theta);
            cur_theta = cur_theta - step_size * gradient;
            previous_step_size = norm(prev_theta - cur_theta);
        end
        
        % gradient of sgd obj function
        function [ val ] = grad_sgd_J( x, y, theta )
            val = 2*x'*(x*theta - y);
        end
        
        %% batch gradient descent
        function [ cur_x, grad_norm, steps, X, Y, Z ] = grad_descent( grad, f, init_x, step_size, precision )
            cur_x = init_x;
            grad_norm = [];
            X = [];
            Y = [];
            Z = [];
            previous_step_size = 100;
            steps = 0;
            while previous_step_size > precision
                prev_x = cur_x;
                X = [X; prev_x(1)];
                Y = [Y; prev_x(2)];
                gradient = grad(prev_x);
                Z = [Z; f(cur_x)];
                grad_norm = [grad_norm; norm(gradient)];
                cur_x = cur_x - step_size * gradient;
                previous_step_size = norm(cur_x - prev_x);
                steps = steps + 1;
            end

        end
        
        % batch gradient descent objective function
        function [ val ] = batch_J( X, Y, theta )
            val = sum((X*theta - Y).^2);
        end
        % gradient of batch obj function
        function [ val ] = grad_batch_J( X, Y, theta )
            val = 2*X'*(X*theta - Y);
        end
        
        %% central difference approximation
         % a numerical way to evaluate a gradient
         % x - point of interest
         % f - the function
         % h - the step size
         
        function [ val ] = central_diff(x, f, h )

            x1 = x(1);
            x2 = x(2);

            fx = (f([x1 + h;     x2]) - f([x1 - h;     x2]))/(2*h);
            fy = (f([    x1; x2 + h]) - f([    x1; x2 - h]))/(2*h);

            val = [fx; fy];

        end

        %% functions and gradients
        function [ val ] = quad( x, params )
            A = params{1};
            b = params{2};
            val = 0.5*x'*A*x - x'*b;
        end
        
        function [ val ] = grad_quad( x, params )
            A = params{1};
            b = params{2};
            val = A*x - b;
        end
        
        function [ val ] = gaussian( x, params )
            mu = params{1};
            sigma = params{2};
            val = -10^4/sqrt(2*pi*norm(sigma)) * exp(-0.5*(x-mu)'*inv(sigma)*(x-mu));
        end
        
        function [ val ] = grad_gaussian( x, params )
            mu = params{1};
            sigma = params{2};
            val = -GradientDescent.gaussian(x, params)*inv(sigma)*(x-mu);
        end

    end
    
end

