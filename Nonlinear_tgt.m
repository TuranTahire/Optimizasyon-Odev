% BF2_Optimization_English.m — Bohachevsky 2 Function Optimization
% Using 5 algorithms with 3 fixed initial points. Formatted output included.

clear all; close all; clc;

%% 1. Function and Grid Definition
f  = @func_tgt;         % Objective function
grad = @gradfunc_tgt;   % Gradient
hess = @hessianfunc_tgt;% Hessian

X1 = -50:1:50;
X2 = -50:1:50;
[x1_grid,x2_grid] = meshgrid(X1,X2);
F = x1_grid.^2 + 2*x2_grid.^2 - 0.3*cos(3*pi*x1_grid).*cos(4*pi*x2_grid) + 0.3;

%% 2. Parameters and Initial Points
epsilon    = 1e-4;
max_iter   = 100;
initial_points = [10 -10; -20 15; 5 -5]'; % Fixed 3 initial points
colors     = ['r','g','b'];  % Colors for plotting
ms0 = 8; ms1 = 6;

algoNames    = {'Newton-Raphson','Hestenes-Stiefel', ...
                'Polak-Ribiere','Fletcher-Reeves','Steepest Descent'};
iterCounts   = zeros(5,3);
elapsedTimes = zeros(5,3);

%% 3. Algorithm Loop
for algoIdx = 1:5
    figure('Name',algoNames{algoIdx});
    contourf(x1_grid,x2_grid,F,50); colormap turbo; hold on;
    title(algoNames{algoIdx}); xlabel('x_1'); ylabel('x_2');
    axis([-50 50 -50 50]); set(gca,'FontSize',14);
    
    for i = 1:3
        x = initial_points(:,i);
        f_old = f(x);
        plot(x(1),x(2),'s', 'MarkerEdgeColor',colors(i), ...
             'MarkerFaceColor',colors(i), 'MarkerSize',ms0);
        fprintf('\n%s Algorithm — Initial Point %d\n', algoNames{algoIdx}, i);
        fprintf('k=%d, x1==%.6f , x2==%.6f , f(x)==%.6f , abs.error=0\n', ...
                0, x(1), x(2), f_old);
        k = 1; tic;
        
        switch algoIdx
            case 1  % Newton-Raphson
                while true
                    gk = grad(x);
                    Hk = hess(x);
                    delta = -Hk\gk;
                    x_new = x + delta;
                    f_new = f(x_new);
                    abs_err = abs(f_new - f_old);
                    fprintf('k=%d, x1==%.6f , x2==%.6f , f(x)==%.6f , abs.error=%.6f\n', ...
                            k, x_new(1), x_new(2), f_new, abs_err);
                    plot(x_new(1),x_new(2),'*','Color',colors(i),'MarkerSize',ms1);
                    if norm(grad(x_new)) <= epsilon && abs_err <= epsilon || k >= max_iter
                        elapsed = toc;
                        iterCounts(algoIdx,i) = k;
                        elapsedTimes(algoIdx,i) = elapsed;
                        fprintf('Elapsed time: %.4f seconds — Iterations: %d\n', elapsed, k);
                        break;
                    end
                    x = x_new;
                    f_old = f_new;
                    k = k + 1;
                end

            case {2,3,4,5} % CG variants
                gk = grad(x);
                d = -gk;
                while true
                    x_new = x + 0.03 * d;
                    f_new = f(x_new);
                    g_new = grad(x_new);
                    abs_err = abs(f_new - f_old);
                    fprintf('k=%d, x1==%.6f , x2==%.6f , f(x)==%.6f , abs.error=%.6f\n', ...
                            k, x_new(1), x_new(2), f_new, abs_err);
                    plot(x_new(1),x_new(2),'*','Color',colors(i),'MarkerSize',ms1);
                    
                    if norm(g_new) <= epsilon && abs_err <= epsilon || k >= max_iter
                        elapsed = toc;
                        iterCounts(algoIdx,i) = k;
                        elapsedTimes(algoIdx,i) = elapsed;
                        fprintf('Elapsed time: %.4f seconds — Iterations: %d\n', elapsed, k);
                        break;
                    end

                    % Beta update
                    if algoIdx == 2  % Hestenes-Stiefel
                        y = g_new - gk;
                        beta = (g_new'*y)/(d'*y);
                    elseif algoIdx == 3  % Polak-Ribiere
                        beta = (g_new'*(g_new - gk))/(gk'*gk);
                    elseif algoIdx == 4  % Fletcher-Reeves
                        beta = (g_new'*g_new)/(gk'*gk);
                    elseif algoIdx == 5  % Steepest Descent
                        beta = 0;
                    end

                    d = -g_new + beta * d;
                    x = x_new;
                    gk = g_new;
                    f_old = f_new;
                    k = k + 1;
                end
        end
    end
end

%% 4. Summary Table
Algorithm   = {};
StartPoint  = [];
Iterations  = [];
TimeSeconds = [];
idx = 1;
for j = 1:5
    for i = 1:3
        Algorithm{idx,1}   = algoNames{j};
        StartPoint(idx,1)  = i;
        Iterations(idx,1)  = iterCounts(j,i);
        TimeSeconds(idx,1) = elapsedTimes(j,i);
        idx = idx + 1;
    end
end
Results = table(Algorithm,StartPoint,Iterations,TimeSeconds);
disp(Results);


