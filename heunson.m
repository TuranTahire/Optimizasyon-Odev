clc; clear; close all;

% Başlangıç değerleri
x0 = 0;
y0 = 0.5;
h = 0.2;
N = 3;

% Vektörleri oluştur
x = zeros(1, N+1);
y = zeros(1, N+1);

% İlk değerleri ata
x(1) = x0;
y(1) = y0;

% Heun yöntemi (Geliştirilmiş Euler)
for n = 1:N
    f1 = y(n) - x(n)^2 + 1;                          % k1
    predictor = y(n) + h * f1;                       % y* = y_n + h*f1
    f2 = predictor - (x(n)+h)^2 + 1;                 % k2 = f(x+h, y*)
    y(n+1) = y(n) + (h/2) * (f1 + f2);               % y_{n+1}
    x(n+1) = x(n) + h;                               % x_{n+1}
end

% Sonuçları yazdır
fprintf("Adım\t x_n\t\t y_n (Heun)\n");
for n = 1:N+1
    fprintf("%d\t %.1f\t\t %.6f\n", n-1, x(n), y(n));
end

% Grafik
figure;
plot(x, y, '-o', 'LineWidth', 2);
title('Geliştirilmiş Euler (Heun) Yöntemi ile Sayısal Çözüm');
xlabel('x'); ylabel('y');
grid on;
