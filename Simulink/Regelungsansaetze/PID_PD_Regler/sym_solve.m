syms T_K L_i eta_K K_DG K_PG K_DK K_PK K_IK g k_AWG_K s
G_3 = -360 * eta_K * T_K * s / (2*pi*(T_K * s + 1)*(L_i*s^2 + g));
R_3 = s * K_DG + K_PG;
G_1 = T_K * k_AWG_K * eta_K / (T_K * s^2 + s);
R_1 = (s^2 * K_DK + s * K_PK * K_IK) / s;

solve(s *(1 - G_3 * R_3 + R_1 * G_1) == 0, s)
