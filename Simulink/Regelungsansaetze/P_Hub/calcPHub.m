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

reglerhub.P = 0.8;


