clc; clear; close all;

% Problem: dy/dx = y - x^2 + 1, y(0) = 0.5, h = 0.2
f = @(x, y) y - x^2 + 1;

% Başlangıç değerleri
x0 = 0.0;
y0 = 0.5;
h = 0.2;
N = 3;  % Toplam adım sayısı

% Vektörler
x = zeros(1, N+1);
y = zeros(1, N+1);

% İlk değer
x(1) = x0;
y(1) = y0;

% Başlatıcı (Heun yöntemi)
f0 = f(x(1), y(1));
y_pred = y(1) + h * f0;
f1 = f(x(1) + h, y_pred);
y(2) = y(1) + (h/2)*(f0 + f1);
x(2) = x(1) + h;

clc; clear; close all;

f = @(x, y) x.^2 - y;
x0 = 0;
y0 = 1;
h = 0.2;
N = 3;

x = zeros(1, N+1);
y = zeros(1, N+1);
x(1) = x0;
y(1) = y0;

% Başlatıcı: Heun
f0 = f(x(1), y(1));
y_pred = y(1) + h * f0;
f1 = f(x(1)+h, y_pred);
y(2) = y(1) + (h/2)*(f0 + f1);
x(2) = x(1) + h;

% AB2 adımları
for n = 2:N
    x(n+1) = x(n) + h;
    fn = f(x(n), y(n));
    fn1 = f(x(n-1), y(n-1));
    y(n+1) = y(n) + (h/2)*(3*fn - fn1);
end

% Sonuçları göster
fprintf("Adım\t x_n\t\t y_n (AB2)\n");
for n = 1:N+1
    fprintf("%d\t %.1f\t\t %.6f\n", n-1, x(n), y(n));
end
