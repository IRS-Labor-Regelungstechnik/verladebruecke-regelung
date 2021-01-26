%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Berechnung Polbereichsvorgabe
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameter

% Für die Simulation und Berechnung des Kalman Filters verwendete Parameter:
system.L = 0.03;
% PT1 Glied
system.T_K = 0.03032;
system.K_K = 1;

% mechanisches System:
system.R = 0.046; % Radius Rad
system.ue = 6; % Übersetzungsverhältnis
system.g = 9.81; % Erdbeschleunigung

theta_lb = 0.05; % L upper bound
theta_ub = 1.65; % L lower bound

system.theta = theta_lb:1.6:theta_ub;

%% Polbereich

% Regler:
% lb = 0.05:

% (blau)
% lange große Dämpfung, ab bestimmter Seillänge nimmt Dämpfung schnell ab
% Imaginärteil bleibt lange sehr klein geht dann allerdings ab bestimmtem
% Punkt sehr schnell nach außen
% - oberer teil schwingt etwas (bei kurzem Seil?, auch mit swrl?)
% - oberer teil schwingt bei langem greifer deutlich (ohne swrl)
% + mit swrl schwingt oberer Teil bei langem Seil nicht
a_P = 0.3;
b_P = 0.6;
R_P = 43;

P = 100;

K_0 = [-1.774209734276011e+02 -52.898729952739885 -19.337951891493990;
    1.237679583918260e+02 25.062015973534102 12.990233214631425];

% Regler
% lb = 0.01:

% (rot)
% + funktioniert für kleine / große Greiferlänge
% - schwingt stark in position
% a_P = 0.1;
% b_P = 0.6;
% R_P = 43;
% 
% P = 100;
% 
% K_0 = [-1.776790781740962e+02 -7.690174526049406 -18.455941343061674;
%     1.238467424443203e+02 1.144790620179561 11.995795897274805];

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





