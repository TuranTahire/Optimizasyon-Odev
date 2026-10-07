function H = hessianfunc_tgt(x)
    x1 = x(1);
    x2 = x(2);
    H11 = 2 + 0.3*(3*pi)^2 * cos(3*pi*x1) * cos(4*pi*x2);
    H22 = 4 + 0.3*(4*pi)^2 * cos(3*pi*x1) * cos(4*pi*x2);
    H12 = -0.3 * 3*pi * 4*pi * sin(3*pi*x1) * sin(4*pi*x2);
    H = [H11, H12; H12, H22];
end
