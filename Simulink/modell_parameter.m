%% Parameters
param.L_0 = 0.5;  % Range: 0.23m - 1.605m
param.init_x1 = 0;
param.phi_0 = 0;
param.T_K = 0.03032;
param.T_G = 0.0247;
param.K_K = 1;
param.K_G = 1;
param.r_K = 0.046; %m
param.r_G = 0.021975; %m
param.ue_dreh = 75;
param.ue_K = 6;
param.ue_G = 3;
param.d = 0.02;  % Daempfung

param.box_sequence = [1,4,5,3,2];

param.g = 9.81;

param.baseline_to_left_switch = 13;  %cm
param.first_box_to_baseline = 22;  %cm
param.distance_between_boxes = 20;  %cm
param.goal_to_last_box = 121.4;  %cm


param.box_height = 11.5;  %cm
param.box_width = 11;  %cm
param.box_lid_width = 14;  %cm

% When determining midpoints, add this height to the box_height
param.add_height_to_midpoints = 3;  %cm

% When grabbing box, drive down this much additionally
param.grab_box_delta = 3;

% Total drivable rail length, in cm
param.total_rail_length = 135.5 + 118.5; 

param.init_x_pos = 127;  %cm, for start and finish positioning
param.init_y_pos = 20;  %cm

% Gripper measurements
param.min_gripper_to_ground = 5;  %cm  
param.gripper_max_length = 163 - 23 - param.min_gripper_to_ground;  %cm

param.k_AWG_K = 1 / (param.total_rail_length / 100); %V/m
param.k_AWG_G = 1 / (param.gripper_max_length / 100); %V/m

param.eta_K = 2*pi*param.r_K*param.K_K*param.ue_dreh/(param.ue_K*param.T_K);
