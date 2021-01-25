%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Berechnung Polbereichsvorgabe
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameter

% Für die Simulation und Berechnung des Kalman Filters verwendete Parameter:
system.L = 0.8;
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

% 1.Opt (gelb)
% geringe Dämpfung
% Imaginärteil geht Richtung neg. Realteil sehr schnell nach außen
% Pol bei L=0.05: -2.524+-j22
% Pol bei L=0.01: -3.424+-j51.06
a_P = 0.6;
b_P = 10.0;
R_P = 50;

P = 10;

% 2.Opt (grün)
% ähnlich zu 3. geht allerdings schon früher nach außen und ist davor im
% vergleich zu 3. nicht so nah an der Re-Achse
% Pol bei L=0.05: -9.669+-j23.24
% Pol bei L=0.01: -11.6+-j63.94
% a_P = 0.6;
% b_P = 1.8;
% R_P = 50;
% 
% P = 100;

% 3.Opt (blau)
% lange große Dämpfung, ab bestimmter Seillänge nimmt Dämpfung schnell ab
% Imaginärteil bleibt lange sehr klein geht dann allerdings ab bestimmtem
% Punkt sehr schnell nach außen
% Pol bei L=0.05: -18.52+-j36.51
% Pol bei L=0.01: -18.81+-j94.07
% a_P = 0.3;
% b_P = 0.6;
% R_P = 43;
% 
% P = 100;

% Startwert für K
% 1. Opt
K_0 = [-8.653076743157850 -10.928242148565472 -16.734418626342208;
    10.714322278350178 -13.482362097801504 6.476553443575402];
% 2. Opt
% K_0 = [-8.079414624883754 -21.840859387736668 -11.390009275798256;
%     11.419213199142842 -4.728410602463830 4.247772004997906];
% 3. Opt
% K_0 = [-1.774209734276011e+02 -52.898729952739885 -19.337951891493990;
%     1.237679583918260e+02 25.062015973534102 12.990233214631425];

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





