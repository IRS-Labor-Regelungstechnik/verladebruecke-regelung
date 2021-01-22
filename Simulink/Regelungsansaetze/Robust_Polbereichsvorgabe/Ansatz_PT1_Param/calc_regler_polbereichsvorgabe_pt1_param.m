%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Berechnung Polbereichsvorgabe
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameter

% Für die Simulation und Berechnung des Kalman Filters verwendete Parameter:
system.L = 0.4;
% PT1 Glied
system.T_K = 1; % 0.03032
system.K_K = 1;

% mechanisches System:
system.R = 0.046; % Radius Rad
system.ue = 6; % Übersetzungsverhältnis
system.g = 9.81; % Erdbeschleunigung

theta1_lb = 0.15; % L upper bound
theta1_ub = 1.65; % L lower bound

theta2_lb = 0.03; % T_K upper bound
theta2_ub = 1.0; % T_K lower bound

system.theta1 = theta1_lb:1.5:theta1_ub;
system.theta2 = theta2_lb:0.97:theta2_ub;

%% nur messbare Zustände zurückgeführt
%% Polbereich

a_P = 0.39;
b_P = 5.0;
R_P = 43;

P = 500;

% Startwert für K
K_0 = [0.223325103890429 -1.604664752468023e+02 2.703819621265890e+02;
    -0.114913897985755 -2.035369632621684 4.514258453015668];

%% Optimierung

x0(1) = K_0(1,1);
x0(2) = K_0(1,2);
x0(3) = K_0(1,3);
x0(4) = K_0(2,1);
x0(5) = K_0(2,2);
x0(6) = K_0(2,3);

options = optimoptions(@fminunc,'Display','iter','Algorithm','quasi-newton',...
    'OptimalityTolerance', 1e-9, 'StepTolerance', 1e-9,...
    'MaxFunctionEvaluations', 10000, 'MaxIterations', 10000);
[x, fval] = fminunc(@(x)guetemass_pt1_param(x, a_P, b_P, R_P, P, system), x0, options);

%% Ergebnisse

% Dynamischer Regler
% VZ siehe RLM 7-2 unten
A_D = -x(6);
B_D = [-x(4), -x(5)];
C_D = x(3);
D_D = [x(1), x(2)];





