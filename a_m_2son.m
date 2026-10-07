clc; clear; close all;

f = @(x, y) exp(-x) - y;

x0 = 0; y0 = 0; h = 0.2; N = 2;

x = zeros(1, N+1);
y = zeros(1, N+1);
x(1) = x0; y(1) = y0;

% Heun başlatıcı
f0 = f(x(1), y(1));
y_pred = y(1) + h * f0;
f1 = f(x(1) + h, y_pred);
y(2) = y(1) + (h/2) * (f0 + f1);
x(2) = x(1) + h;

% AM2 döngüsü
for n = 2:N
    x(n+1) = x(n) + h;

    fn1 = f(x(n-1), y(n-1));
    fn  = f(x(n),   y(n));

    % Predictor: AB2
    y_pred = y(n) + (h/2)*(3*fn - fn1);

    % Corrector: AM2
    f_np1 = f(x(n+1), y_pred);
    y(n+1) = y(n) + (h/12) * (5*f_np1 + 8*fn - fn1);
end

fprintf("Adım\t x_n\t\t y_n (AM2)\n");
for n = 1:N+1
    fprintf("%d\t %.1f\t\t %.6f\n", n-1, x(n), y(n));
end

% Grafik
figure;
plot(x, y, '-o', 'LineWidth', 2);
title('Adams-Moulton 2-Adımlı Yöntemi');
xlabel('x'); ylabel('y');
grid on;

