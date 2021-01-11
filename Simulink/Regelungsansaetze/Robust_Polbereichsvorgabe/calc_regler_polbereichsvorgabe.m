%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Berechnung Polbereichsvorgabe
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameter

% tatsächliches L
system.currL = 0.4;

% mechanisches System:
system.R = 0.046; % Radius Rad
system.ue = 6; % Übersetzungsverhältnis
system.g = 9.81; % Erdbeschleunigung

theta_lb = 0.2; % L upper bound
theta_ub = 1.5; % L lower bound

system.theta = theta_lb:1.3:theta_ub;

% PT1 Glied
system.T_K = 0.1;
system.K_K = 1;

%% nicht messbare Zustände zurückgeführt
% %% Polbereich
% % 1. Opt
% a_P = 0.4;
% b_P = 0.5;
% R_P = 42;
% 
% P = 100;
% 
% % 2. Opt
% % a_P = 0.4;
% % b_P = 0.5;
% % R_P = 50;
% % 
% % P = 100;
% 
% % Startwert für K
% % 1. Opt
% K_0 = [2.420434174155651 -6.128448567404450 -2.355456328021400e+02 85.895782639937800;
%     -2.853425070952290 -0.252297636337563 -86.984684077883030 42.381592685553960];
% % 2. Opt
% % K_0 = [11.821548947235597 -3.673922387423609 -2.391178947532412e+02 90.671686938113520;
% %     1.565752126149077 0.796880560675630 -82.710040049216830 42.113730857151424];
% 
% %% Optimierung
% 
% x0(1) = K_0(1,1);
% x0(2) = K_0(1,2);
% x0(3) = K_0(1,3);
% x0(4) = K_0(1,4);
% x0(5) = K_0(2,1);
% x0(6) = K_0(2,2);
% x0(7) = K_0(2,3);
% x0(8) = K_0(2,4);
% 
% options = optimoptions(@fminunc,'Display','iter','Algorithm','quasi-newton',...
%     'OptimalityTolerance', 1e-9, 'StepTolerance', 1e-9,...
%     'MaxFunctionEvaluations', 10000, 'MaxIterations', 10000);
% [x, fval] = fminunc(@(x)guetemass(x, a_P, b_P, R_P, P, system), x0, options);

%% nur messbare Zustände zurückgeführt
%% Polbereich
% 1. Opt
a_P = 0.4;
b_P = 0.5;
R_P = 42;

P = 100;

% 2. Opt
% a_P = 0.4;
% b_P = 0.5;
% R_P = 50;
% 
% P = 100;

% Startwert für K
% 1. Opt
K_0 = [-1.689527858519600e+02 -2.328007745025536e+02 83.207661131782460;
    -82.403596134447840 -78.286301444746780 38.567020828655380];
% 2. Opt
% K_0 = [11.821548947235597 -3.673922387423609 -2.391178947532412e+02 90.671686938113520;
%     1.565752126149077 0.796880560675630 -82.710040049216830 42.113730857151424];

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





