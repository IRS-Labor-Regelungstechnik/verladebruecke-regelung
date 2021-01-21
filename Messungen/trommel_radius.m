function r = trommel_radius(L)
    L_max = 160.5; %cm
    L_min = 23; %cm
    r_1 = 2.35; %cm
    r_0 = 1.85;  %cm
    r = ((r_0 - r_1) / (L_max - L_min)) * (L - L_min) + r_1;
end