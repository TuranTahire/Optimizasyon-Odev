clc; clear; close all;

% Problem parametreleri
T_env = 20;
T0 = 100;
k = 0.1;
h = 0.2;
N = 10;
t = 0:h:N*h;

% Fonksiyonlar
f = @(T) -k * (T - T_env);
f2 = @(T) k^2 * (T - T_env);

% Başlangıç vektörleri
T_euler   = zeros(1, N+1);
T_heun    = zeros(1, N+1);
T_rk2     = zeros(1, N+1);
T_rk4     = zeros(1, N+1);
T_ab2     = zeros(1, N+1);
T_am2     = zeros(1, N+1);
T_pc      = zeros(1, N+1);
T_taylor  = zeros(1, N+1);

% Başlangıç değerleri (her yönteme ayrı ayrı)
T_euler(1)   = T0;
T_heun(1)    = T0;
T_rk2(1)     = T0;
T_rk4(1)     = T0;
T_ab2(1)     = T0;
T_am2(1)     = T0;
T_pc(1)      = T0;
T_taylor(1)  = T0;

% Euler Yöntemi
for n = 1:N
    T_euler(n+1) = T_euler(n) + h * f(T_euler(n));
end

% Heun Yöntemi
for n = 1:N
    k1 = f(T_heun(n));
    k2 = f(T_heun(n) + h * k1);
    T_heun(n+1) = T_heun(n) + (h/2)*(k1 + k2);
end

% Runge-Kutta 2. Derece (RK2)
for n = 1:N
    k1 = f(T_rk2(n));
    k2 = f(T_rk2(n) + h * k1);
    T_rk2(n+1) = T_rk2(n) + (h/2)*(k1 + k2);
end

% Runge-Kutta 4. Derece (RK4)
for n = 1:N
    k1 = f(T_rk4(n));
    k2 = f(T_rk4(n) + (h/2)*k1);
    k3 = f(T_rk4(n) + (h/2)*k2);
    k4 = f(T_rk4(n) + h*k3);
    T_rk4(n+1) = T_rk4(n) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
end

% Adams-Bashforth 2. Derece (AB2)
T_ab2(2) = T_ab2(1) + (h/2)*(f(T_ab2(1)) + f(T_ab2(1) + h * f(T_ab2(1))));
for n = 2:N
    T_ab2(n+1) = T_ab2(n) + (h/2)*(3*f(T_ab2(n)) - f(T_ab2(n-1)));
end

% Adams-Moulton 2. Derece (AM2)
T_am2(2) = T_am2(1) + (h/2)*(f(T_am2(1)) + f(T_am2(1) + h * f(T_am2(1))));
for n = 2:N
    f_pred = f(T_am2(n) + (h/2)*(3*f(T_am2(n)) - f(T_am2(n-1))));
    T_am2(n+1) = T_am2(n) + (h/12)*(5*f_pred + 8*f(T_am2(n)) - f(T_am2(n-1)));
end

% Predictor–Corrector (AB2 + AM2)
T_pc(2) = T_pc(1) + (h/2)*(f(T_pc(1)) + f(T_pc(1) + h * f(T_pc(1))));
for n = 2:N
    T_pred = T_pc(n) + (h/2)*(3*f(T_pc(n)) - f(T_pc(n-1)));
    T_pc(n+1) = T_pc(n) + (h/12)*(5*f(T_pred) + 8*f(T_pc(n)) - f(T_pc(n-1)));
end

% Taylor Serisi 2. Derece
for n = 1:N
    T_prime = f(T_taylor(n));
    T_double_prime = f2(T_taylor(n));
    T_taylor(n+1) = T_taylor(n) + h * T_prime + (h^2 / 2) * T_double_prime;
end

% Grafik – Tüm yöntemleri karşılaştır
figure;
plot(t, T_euler, '-o', 'DisplayName', 'Euler'); hold on;
plot(t, T_heun, '-o', 'DisplayName', 'Heun');
plot(t, T_rk2, '-o', 'DisplayName', 'RK2');
plot(t, T_rk4, '-o', 'DisplayName', 'RK4');
plot(t, T_ab2, '-o', 'DisplayName', 'AB2');
plot(t, T_am2, '-o', 'DisplayName', 'AM2');
plot(t, T_pc, '-o', 'DisplayName', 'Predictor–Corrector');
plot(t, T_taylor, '-o', 'DisplayName', 'Taylor');

title("Newton’un Soğuma Kanunu – Sayısal Yöntem Karşılaştırması");
xlabel("t (zaman)");
ylabel("T (sıcaklık)");
legend('Location', 'best');
grid on;







