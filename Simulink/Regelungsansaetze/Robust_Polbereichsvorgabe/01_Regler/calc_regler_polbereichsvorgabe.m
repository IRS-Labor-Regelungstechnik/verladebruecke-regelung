%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Berechnung Polbereichsvorgabe
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameter

% Für die Simulation und Berechnung des Kalman Filters verwendete Parameter:
system.L = 0.5; % nicht für nachfolgende Optimierung relevant
% PT1 Glied
system.T_K = 0.03032;
system.K_K = 1;

% mechanisches System:
system.R = 0.046; % Radius Rad
system.ue = 6; % Übersetzungsverhältnis
system.g = 9.81; % Erdbeschleunigung

theta_lb = 0.01; % L upper bound
theta_ub = 1.65; % L lower bound

system.theta = theta_lb:0.01:theta_ub;

%% Polbereich

% (rot)
% + funktioniert für kleine / große Greiferlänge
% - schwingt ohne Pahsenkompensation stark in Position
a_P = 0.1;
b_P = 1;
R_P = 43;

P = 1000;

K_0 = [-1.777115470498781e+02 -7.779318939205798 -18.293179401805690;
        1.238243733364166e+02 0.939714202995980 11.944952648562522];

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





