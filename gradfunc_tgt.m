function g = gradfunc_tgt(x)
    x1 = x(1);
    x2 = x(2);
    df_dx1 = 2*x1 + 0.9*pi * sin(3*pi*x1) * cos(4*pi*x2);
    df_dx2 = 4*x2 + 1.2*pi * cos(3*pi*x1) * sin(4*pi*x2);
    g = [df_dx1; df_dx2];
end
