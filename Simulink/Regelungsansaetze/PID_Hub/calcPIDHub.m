%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Berechnung PID-Regler Hub
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameter

systemhub.K_G = 1;
systemhub.T_G = 0.0247;

systemhub.R = 0.021975;
systemhub.ue = 3;

systemhub.k_AWG = 1/1.375;
systemhub.ue_dreh = 75;

systemhub.eta = pi * systemhub.R * systemhub.K_G * systemhub.ue_dreh / (systemhub.ue * systemhub.T_G);

%% Berechnung Regler
% bewährte Parameter
% P: 1.0457392449245
% I: 0.44033447408914


% Auslegung nach Symmetrischem Optimum

phasenreserve = 65 * (2*pi/360);
%a = (1 + sin(phasenreserve)) / cos(phasenreserve);
a=2;

K_s = systemhub.k_AWG * systemhub.eta * systemhub.T_G;
T_E = systemhub.T_G;
T_0 = 1;

% Regler:
K_R = T_0 / (a * K_s * T_E);
T_N = a^2 * T_E;

P_regler = K_R;
I_regler = K_R / T_N;

