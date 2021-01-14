%% Parameters

param.L_0 = 1.3;
param.init_x1 = 0;
param.phi_0 = 0;
param.T_K = 0.1;
param.T_G = 0.05;
param.K_K = 1;
param.K_G = 1;
param.r_K = 0.046;
param.r_G = 0.05;
param.ue_K = 6;
param.ue_G = 3;
param.d = 0.02;  % Daempfung
param.k_AWG_K = 39.37;
param.k_AWG_G = 39.37;

st1 = 1;  % for lin_modell_test and nl_modell_test

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