% ================================
% FLETCHER-REEVES ALGORITHM (FR)
% ================================

figure('Position', [100, 100, 800, 600]);
set(gca, 'FontSize', 14)

% Grid ve kontur
X1 = -2:0.05:2;
X2 = -2:0.05:2;
[x1, x2] = meshgrid(X1, X2);
F = x1.^2 + 2*x2.^2 - 0.3*cos(3*pi*x1).*cos(4*pi*x2) + 0.3;

contourf(x1, x2, F, 50)
colormap turbo
hold on
title('Fletcher-Reeves Method')
xlabel('x_1'); ylabel('x_2');
axis([-2 2 -2 2])

% Başlangıç noktaları
x_init = [0.5 -0.5; -1 1; 0.2 0.3]';
colors = ['r', 'g', 'b'];
markers = ['o', 's', '^'];
epsilon = 1e-4;
max_iter = 100;

% Legend objeleri
h1 = plot(x_init(1,1), x_init(2,1), 'ro', 'MarkerSize', 12, ...
    'LineWidth', 2, 'MarkerFaceColor', 'r');
h2 = plot(x_init(1,2), x_init(2,2), 'gs', 'MarkerSize', 12, ...
    'LineWidth', 2, 'MarkerFaceColor', 'g');
h3 = plot(x_init(1,3), x_init(2,3), 'b^', 'MarkerSize', 12, ...
    'LineWidth', 2, 'MarkerFaceColor', 'b');

legend([h1 h2 h3], {'Start 1', 'Start 2', 'Start 3'}, 'Location', 'best')

% Algoritma
for i = 1:3
    x = x_init(:, i);
    g = gradfunc_tgt(x);
    d = -g;
    k = 1;

    fprintf('\nFletcher-Reeves, Başlangıç Noktası %d:\n', i)
    fprintf('k=%d, x=[%.4f %.4f], f=%.4f\n', k, x(1), x(2), func_tgt(x));

    while norm(g) > epsilon && k < max_iter
        alpha = 0.03;
        x_new = x + alpha * d;
        g_new = gradfunc_tgt(x_new);
        
        % FR beta formülü
        beta_FR = (g_new' * g_new) / (g' * g);
        d = -g_new + beta_FR * d;

        plot(x_new(1), x_new(2), [colors(i) '*'], 'MarkerSize', 9, 'LineWidth', 1.5)

        x = x_new;
        g = g_new;
        k = k + 1;

        fprintf('k=%d, x=[%.4f %.4f], f=%.4f, grad norm=%.6f\n', ...
            k, x(1), x(2), func_tgt(x), norm(g))
    end
end
