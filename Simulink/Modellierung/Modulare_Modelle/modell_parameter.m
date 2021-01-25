%% Parameters

param.L_0 = 1;  % Range: 0.23m - 1.605m
param.init_x1 = 0;
param.phi_0 = 0;
param.T_K = 0.1;
param.T_G = 0.05;
param.K_K = 1;
param.K_G = 1;
param.r_K = 0.046; %m
param.r_G = 0.05; %m
param.ue_dreh = 750;
param.ue_K = 6;
param.ue_G = 3;
param.d = 0.02;  % Daempfung
param.k_AWG_K = 0.3937; %V/m
param.k_AWG_G = 0.7273; %V/m

param.eta_K = 2*pi*param.r_K*param.K_K*param.ue_dreh/(param.ue_K*param.T_K);

% Automatisierung
box_sequence = 1:5;
start_time = 5;

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

% L_0 = 1m
A_1 = A(1);
B_1 = B(1);
C_1 = C;

transfunc.Y_1_numer = [param.k_AWG_K * param.eta_K];
transfunc.Y_1_denom = [1, 1/param.T_K 0];
sys_1 = tf(transfunc.Y_1_numer, transfunc.Y_1_denom);
% bode(sys_1)

% sisotool
% sisotool('bode',G);

transfunc.Y_3_numer = [-param.eta_K*param.T_K, 0];
transfunc.Y_3_denom = [param.T_K, param.L_0, 9.81*param.T_K, 9.81];
sys_3 = tf(transfunc.Y_3_numer, transfunc.Y_3_denom);
% bode(sys_3)

K_PK = 1;
K_IK = 1;
K_DK = 1;
K_filterK = 1/200;
K_PG = 1;
K_DG = 1;
K_filterG = 1/200;
R_1 = pid(K_PK, K_IK, K_DK, 1);
R_2 = pid(K_PG, 0, K_DG);

% figure;bode(sys_1,'b--',sys_3,'b', sys_1 * R_1, 'r', sys_3 * R_1, 'r--');grid;
% legend('Laufkatze','Winkel');

