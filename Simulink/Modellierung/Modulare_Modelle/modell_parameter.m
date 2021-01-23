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

param.u_weight = 2*pi*param.r_K*param.K_K*param.ue_dreh/(param.ue_K*param.T_K);

st1 = 1;  % for lin_modell_test and nl_modell_test

A = @(L_0) [0, 1, 0, 0;
            0, -1/param.T_K, 0, 0;
            0, 0, 0, 1;
            0, 1/(param.T_K*L_0), -9.81/L_0, 0];
B = @(L_0) [0; 
            param.u_weight; 
            0; 
            -param.u_weight/param.L_0];
C = [param.k_AWG_K, 0,0 ,0;
     0, 0, 1, 0];

% L_0 = 1m
A_1 = A(1);
B_1 = B(1);
C_1 = C;

transfunc.Y_1_numer = [param.k_AWG_K * param.u_weight];
transfunc.Y_1_denom = [1, 1/param.T_K 0];

transfunc.Y_3_numer = [-param.u_weight*param.T_K, 0];
transfunc.Y_3_denom = [param.T_K, param.L_0, 9.81*param.T_K, 9.81];

%% Input

% %Spannung
% assignin('base', 'u1',0.1)
% assignin('base', 'u2',0.1)
% %Start
% assignin('base', 't01',0)
% assignin('base', 't02',5)
% %Ende
% assignin('base', 't1',5)
% assignin('base', 't2',8)
% 
% %% Nonlinear Model
% 
% assignin('base', 'T1',T1)
% assignin('base', 'r1',r1)
% assignin('base', 'ue1',ue1)
% 
% assignin('base', 'T2',T2)
% assignin('base', 'r2',r2)
% assignin('base', 'ue2',ue2)
% 
% assignin('base', 'L_0',L_0)
% assignin('base', 'x_0',x_0)
% assignin('base', 'phi_0',phi_0)