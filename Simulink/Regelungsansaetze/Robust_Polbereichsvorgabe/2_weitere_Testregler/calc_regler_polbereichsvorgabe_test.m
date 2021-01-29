%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Berechnung Polbereichsvorgabe
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameter

% Für die Simulation und Berechnung des Kalman Filters verwendete Parameter:
system.L = 1.5;
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

% (-) (gelb)
% geringe Dämpfung
% Imaginärteil geht Richtung neg. Realteil sehr schnell nach außen
% schwingt stark ohne swrl
% schwingt minimal auch mit swrl
a_P = 0.6;
b_P = 10.0;
R_P = 50;

P = 10;

K_0 = [-8.653076743157850 -10.928242148565472 -16.734418626342208;
    10.714322278350178 -13.482362097801504 6.476553443575402];

% (-) (grün) -> mit doppelter RL Rückführung testen
% ähnlich zu blau geht allerdings schon früher nach außen und ist davor im
% vergleich zu blau nicht so nah an der Re-Achse
% - schwingt deutlich ohne swrl
% - mit swrl auch aber etwas weniger
% a_P = 0.6;
% b_P = 1.8;
% R_P = 50;
% 
% P = 100;
% 
% K_0 = [-8.079414624883754 -21.840859387736668 -11.390009275798256;
%     11.419213199142842 -4.728410602463830 4.247772004997906];

% (-) (zwischen grün und lila) -> mit doppelter RL Rückführung testen (sehr geringe Überschwinger)
% schwingt ohne swrl deutlich
% schwingt auch mit swrl
% a_P = 0.4;
% b_P = 1.0;
% R_P = 43;
% 
% P = 10;
% 
% K_0 = [-5.056767567669567 -33.307418571680730 -9.266543917421830;
%     11.764154350160240 -5.609845627304680 4.536682973988588];

% Regler:
% lb = 0.01:

% (-) ähnlich zu rot
% allerdings alle EW etwas nach rechts verschoben
% + funktioniert mit swrl
% + ohne swrl auch keine hochfreq schwingungen
% - starke schwingung in position
% a_P = 0.1;
% b_P = 0.6;
% R_P = 40;
% 
% P = 1000;
% 
% K_0 = [-1.338388545504427e+02 -5.995525251080967 -10.450759757394980;
%     1.206979998483719e+02 2.276826484979793 8.475572221576634];

% (-) ähnlich zu rot
% allerdings nach links verschoben
% - ganz leichte schwingungen in oberem winkelteil (auch mit swrl?)
% - starke schingung in position
% + sonst funktioniert er gut
% a_P = 0.15;
% b_P = 0.6;
% R_P = 60;
% 
% P = 1000;
% 
% K_0 = [-1.783545141511604e+02 -17.776512482941925 -17.310662990411030;
%     1.236379468108141e+02 8.353049698429627 11.369026124583993];

% Regler:
% lb = 0.15:

% (?) (lila)
% a_P = 0.6;
% b_P = 1.0;
% R_P = 43;
% 
% P = 1000;
% 
% K_0 = [-1.785777488051462e+02 -39.253338189456370 2.761578135129279e+02;
%     -9.780470899819305 -1.011840131826977 14.472030984989194];

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





