function f = func_tgt(x)
    x1 = x(1);
    x2 = x(2);
    f = x1^2 + 2*x2^2 - 0.3*cos(3*pi*x1)*cos(4*pi*x2) + 0.3;
end
