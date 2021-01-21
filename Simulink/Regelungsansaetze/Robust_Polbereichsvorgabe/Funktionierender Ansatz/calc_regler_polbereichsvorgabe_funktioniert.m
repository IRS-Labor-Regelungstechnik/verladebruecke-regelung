%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Berechnung Polbereichsvorgabe
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameter

% Für die Simulation und Berechnung des Kalman Filters verwendete Parameter:
system.L = 0.4; % nur für Simulation benötigt
% PT1 Glied
system.T_K = 0.03032;
system.K_K = 1;

% mechanisches System:
system.R = 0.046; % Radius Rad
system.ue = 6; % Übersetzungsverhältnis
system.g = 9.81; % Erdbeschleunigung

theta_lb = 0.01; % L upper bound
theta_ub = 1.65; % L lower bound

system.theta = theta_lb:1.64:theta_ub;

%% Polbereich

% 1.Opt
% funktioniert sicher für große Länge (für alle Längen (!?))
a_P = 0.1;
b_P = 0.6;
R_P = 43;

P = 100;

% Alternative Regler:
% 2.Opt
% a_P = 0.4;
% b_P = 1.0;
% R_P = 43;
% 
% P = 10;

% 3.Opt mit theta_lb 0.05
% a_P = 0.4;
% b_P = 0.6;
% R_P = 43;
% 
% P = 10;

% Startwert für K
% 1. Opt
K_0 = [-1.776790781740962e+02 -7.690174526049406 -18.455941343061674;
    1.238467424443203e+02 1.144790620179561 11.995795897274805];
% Alternative Regler:
% 2. Opt
% K_0 = [-5.056767567669567 -33.307418571680730 -9.266543917421830;
%     11.764154350160240 -5.609845627304680 4.536682973988588];
% 3. Opt
% K_0 = [-1.773568730237216e+02 -14.115608919457802 -20.476130357627200;
%     1.236811504949734e+02 12.323348089922725 13.359887005868284];
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
[x, fval] = fminunc(@(x)guetemass(x, a_P, b_P, R_P, P, system), x0, options);

%% Ergebnisse

% Dynamischer Regler
% VZ siehe RLM 7-2 unten
A_D = -x(6);
B_D = [-x(4), -x(5)];
C_D = x(3);
D_D = [x(1), x(2)];





