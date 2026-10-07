clc; clear; close all;

% Başlangıç değerleri
x0 = 0;
y0 = 1;
h = 0.1;
N = 3; % adım sayısı

% Vektörleri oluştur
x = zeros(1, N+1);
y = zeros(1, N+1);

% Başlangıç değerlerini yerleştir
x(1) = x0;
y(1) = y0;

% Euler yöntemi döngüsü
for n = 1:N
    f = x(n) + y(n);                % f(x_n, y_n) = x + y
    y(n+1) = y(n) + h * f;          % y_{n+1} = y_n + h*f
    x(n+1) = x(n) + h;              % x_{n+1} = x_n + h
end

% Sonuçları tablo olarak göster
fprintf("Adım\t x_n\t\t y_n (Euler)\n");
for n = 1:N+1
    fprintf("%d\t %.1f\t\t %.6f\n", n-1, x(n), y(n));
end

% İsteğe bağlı grafik
figure;
plot(x, y, '-o', 'LineWidth', 2);
title('Euler Yöntemi ile Sayısal Çözüm');
xlabel('x');
ylabel('y');
grid on;
