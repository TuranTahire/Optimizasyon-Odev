clc; clear; close all;

f = @(x, y) x.^2 + y.^2;
df = @(x, y, dy) 2*x + 2*y.*dy;

x0 = 0; y0 = 0; h = 0.2; N = 3;

x = x0:h:x0 + N*h;
y = zeros(1, N+1);
y(1) = y0;

for n = 1:N
    dy = f(x(n), y(n));
    ddy = df(x(n), y(n), dy);
    y(n+1) = y(n) + h*dy + (h^2/2)*ddy;
end

fprintf("Adım\t x_n\t\t y_n (Taylor)\n");
for n = 1:N+1
    fprintf("%d\t %.1f\t\t %.6f\n", n-1, x(n), y(n));
end

% Grafik
figure;
plot(x, y, '-o', 'LineWidth', 2);
title('Taylor Serisi Yöntemi (2. Derece)');
xlabel('x'); ylabel('y');
grid on;
