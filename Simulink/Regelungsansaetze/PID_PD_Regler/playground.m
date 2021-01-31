


st1 = 1;  % for lin_modell_test and nl_modell_test

A = @(L_0) [0, 1, 0, 0;
            0, -1/param.T_K, 0, 0;
            0, 0, 0, 1;
            0, 1/(param.T_K*L_0), -9.81/L_0, 0];
B = @(L_0) [0; 
            param.eta_K; 
            0; 
            -param.eta_K/param.L_0];
C = [param.k_AWG_K, 0,0 ,0;
     0, 0, 360/(2*pi), 0];

% L_0 = 0.5m
A_05 = A(0.5);
B_05 = B(0.5);

% L_0 = 1m
A_1 = A(1);
B_1 = B(1);

transfunc.Y_1_numer = [param.k_AWG_K * param.eta_K];
transfunc.Y_1_denom = [1, 1/param.T_K 0];
G_1 = tf(transfunc.Y_1_numer, transfunc.Y_1_denom);
% bode(sys_1)

% sisotool
% sisotool('bode',G);

transfunc.Y_3_numer = [-param.eta_K*param.T_K, 0];
transfunc.Y_3_denom = [param.T_K, param.L_0, 9.81*param.T_K, 9.81];
G_3 = tf(transfunc.Y_3_numer, transfunc.Y_3_denom);
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
