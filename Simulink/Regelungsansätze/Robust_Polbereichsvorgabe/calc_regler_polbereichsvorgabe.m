% Berechnung Polbereichsvorgabe


%% Parameter

% tatsächliches L
system.currL = 0.2;

% mechanisches System:
system.R = 0.046; % Radius Rad
system.ue = 6; % Übersetzungsverhältnis
system.g = 9.81; % Erdbeschleunigung

theta_lb = 0.2; % L upper bound
theta_ub = 1.5; % L lower bound

system.theta = theta_lb:1:theta_ub;

% PT1 Glied
system.T_K = 0.1;
system.K_K = 1;

%% Polbereich
% init Werte
% a_P = 0.6;
% b_P = 0.5;
% R_P = 50;

% 1. Opt
% a_P = 0.3;
% b_P = 1;
% R_P = 20;
% 
% P = 10000;

% 2.Opt
a_P = 0.3;
b_P = 1;
R_P = 20;

P = 10000;

% Startwert für K
%init werte
% K_0 = [10 10 -100 10;
%        -1 10 -20 10];

% 1.Opt
% K_0 = [6.303839813126968 4.941571478107184 -1.015623946764358e+02 13.132809379078788;
%        3.508130611657109 14.731065201385643 -18.435033018857553 7.119490367027512];
   
% 2.Opt
K_0 = [6.303839813126968 4.941571478107184 -1.015623946764358e+02 13.132809379078788;
       3.508130611657109 14.731065201385643 -18.435033018857553 7.119490367027512];
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
%[x, fval] = fmincon(@(x)guetemass(x, a_P, b_P, R_P, P, system), x0, [], [], [], [], [], [], @(x)nonlcon(x, a_P, b_P, R_P, P, system), options);

%% Ergebnisse

% Dynamischer Regler
A_D = -x(8);
B_D = [x(5), x(6), x(7)];
C_D = x(4);
D_D = [x(1), x(2), x(3)];

