clc; clear; close all;

% Başlangıç değerleri
x0 = 0.0;
y0 = 1.0;
h = 0.2;
N = 3; % Adım sayısı

% x ve y için boş diziler
x = zeros(1, N+1);
y = zeros(1, N+1);

% İlk değerleri yerleştir
x(1) = x0;
y(1) = y0;

% f fonksiyonu: dy/dx = cos(x) - y
f = @(x, y) cos(x) - y;

% RK4 döngüsü
for n = 1:N
    k1 = f(x(n), y(n));
    k2 = f(x(n) + h/2, y(n) + h/2 * k1);
    k3 = f(x(n) + h/2, y(n) + h/2 * k2);
    k4 = f(x(n) + h,   y(n) + h * k3);

    y(n+1) = y(n) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    x(n+1) = x(n) + h;
end

% Sonuçları yazdır
fprintf("Adım\t x_n\t\t y_n (RK4)\n");
for n = 1:N+1
    fprintf("%d\t %.1f\t\t %.6f\n", n-1, x(n), y(n));
end

% Grafik çizimi
figure;
plot(x, y, '-o', 'LineWidth', 2);
title('Runge-Kutta 4. Derece Yöntemi');
xlabel('x');
ylabel('y');
grid on;
