clc; clear; close all;

% Başlangıç değerleri
x0 = 1.0;
y0 = 2.0;
h = 0.2;
N = 3; % Adım sayısı

% x ve y için vektörler
x = zeros(1, N+1);
y = zeros(1, N+1);

% İlk değerleri ata
x(1) = x0;
y(1) = y0;

% Runge-Kutta 2. Derece (Midpoint) yöntemi
for n = 1:N
    k1 = y(n) / x(n);                                      % f(x_n, y_n)
    k2 = (y(n) + h/2 * k1) / (x(n) + h/2);                 % f(x_n + h/2, y_n + h/2 * k1)
    y(n+1) = y(n) + h * k2;                                % y_{n+1}
    x(n+1) = x(n) + h;                                     % x_{n+1}
end

% Sonuçları yazdır
fprintf("Adım\t x_n\t\t y_n (RK2)\n");
for n = 1:N+1
    fprintf("%d\t %.1f\t\t %.6f\n", n-1, x(n), y(n));
end

% Grafik çizimi
figure;
plot(x, y, '-o', 'LineWidth', 2);
title('Runge-Kutta 2. Derece Yöntemi (Midpoint)');
xlabel('x'); ylabel('y');
grid on;
