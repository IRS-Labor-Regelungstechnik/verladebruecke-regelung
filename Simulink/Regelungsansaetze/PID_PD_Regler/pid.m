% bode(sys_3)

% K_PK = 1;
% K_IK = 1;
% K_DK = 1;
% K_filterK = 1/200;
% K_PG = 1;
% K_DG = 1;
% K_filterG = 1/200;
% R_1 = pid(K_PK, K_IK, K_DK, 1);
% R_3 = pid(K_PG, 0, K_DG);

% tf_R_1 = tf(R_1);
% F_o = R_1 / (1- G_3 * R_3);

% figure;bode(sys_1,'b--',sys_3,'b', sys_1 * R_1, 'r', sys_3 * R_1, 'r--');grid;
% legend('Laufkatze','Winkel');