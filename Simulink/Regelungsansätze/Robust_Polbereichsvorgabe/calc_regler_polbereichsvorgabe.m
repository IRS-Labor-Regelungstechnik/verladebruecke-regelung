% Berechnung Polbereichsvorgabe


%% Parameter

% tatsächliches L
system.currL = 0.8;

% mechanisches System:
system.R = 0.046; % Radius Rad
system.ue = 6; % Übersetzungsverhältnis
system.g = 9.81; % Erdbeschleunigung

theta_lb = 0.2; % L upper bound
theta_ub = 1.5; % L lower bound

system.theta = theta_lb:0.1:theta_ub;

% PT1 Glied
system.T_K = 0.1;
system.K_K = 1;

%% Polbereich
% 1. Opt
a_P = 0.3;
b_P = 1;
R_P = 30;

P = 100;

% 2. Opt
% a_P = 0.5;
% b_P = 1;
% R_P = 30;
% 
% P = 1000;

% Startwert für K
% 1. Opt
K_0 = [6.468678057078177 0.342754239288572 -1.943268863731647e+02 9.489519174220458;
    3.458082508193279 11.863360291165450 -13.556172011918596 3.739797159231069];
% 2. Opt
% K_0 = [6.625744704273791 31.350420266633590 -4.255608131017686e+02 16.825786962735320;
%     2.566485118651463 15.715024288702256 -16.323016255759730 3.767701669239048];

%% Optimierung

x0(1) = K_0(1,1);
x0(2) = K_0(1,2);
x0(3) = K_0(1,3);
x0(4) = K_0(1,4);
x0(5) = K_0(2,1);
x0(6) = K_0(2,2);
x0(7) = K_0(2,3);
x0(8) = K_0(2,4);

options = optimoptions(@fminunc,'Display','iter','Algorithm','quasi-newton', 'OptimalityTolerance', 1e-9, 'StepTolerance', 1e-9, 'MaxFunctionEvaluations', 10000, 'MaxIterations', 10000);
[x, fval] = fminunc(@(x)guetemass(x, a_P, b_P, R_P, P, system), x0, options);

%% Ergebnisse

% Dynamischer Regler
A_D = -x(8);
B_D = [-x(5), -x(6), -x(7)];
C_D = -x(4);
D_D = [x(1), x(2), x(3)]; % nicht negativ da mit -y multipliziert

