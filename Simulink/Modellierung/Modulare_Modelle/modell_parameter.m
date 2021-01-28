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

system.currL = param.L_0;

% mechanisches System:
system.R = param.r_K; % Radius Rad
system.ue = param.ue_K; % ?bersetzungsverh?ltnis
system.g = 9.81; % Erdbeschleunigung

% PT1 Glied
system.T_K = param.T_K;
system.K_K = param.K_K;


param.eta_K = 2*pi*param.r_K*param.K_K*param.ue_dreh/(param.ue_K*param.T_K);


param.baseline_to_left_switch = 4.5;  %cm
param.first_box_to_baseline = 22;  %cm
param.distance_between_boxes = 20;  %cm
param.goal_to_last_box = 121.4;  %cm


param.box_height = 11.5;  %cm
param.box_width = 11;  %cm
param.box_lid_width = 14;  %cm

% When determining midpoints, add this height to the box_height
param.add_height_to_midpoints = 3;  %cm

% Total drivable rail length, in cm
param.total_rail_length = 135.8 + 118.2; 

param.init_x_pos = 127;  %cm, for start and finish positioning
param.init_y_pos = 10;  %cm

% Gripper measurements
param.gripper_max_length = 137.5;  %cm
param.min_gripper_to_ground = 2.5;  %cm    

% Automatisierung
param.box_sequence = 1:5;
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

