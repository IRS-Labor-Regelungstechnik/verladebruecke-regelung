%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% berechne Kalmanfilter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% f�hre zuerst calc_regler_polbereichsvorgabe aus um die ben�tigten
% Parameter in den Workspace zu laden

%% St�rgr��enaufschaltung
% berechne Matrizen f�r St�rgr��enaufschaltung
sys = system;
[~, ~, ~, matB, matE] = calcSysMatrixKleinStoer(sys);

%% berechne Kalman-Filter

% Kovarianz
matR_ges = diag([1; 1]); % Kovarianzmatrix Ausgangsrauschen
matQ_ges = diag([1; 15]); % Kovarianzmatrix Systemrauschen

% Systemrauschen
[~, matB_ges, ~, ~, ~, ~, ~] = calcSysMatrixStoer(sys);

matG_ges = [matB_ges; matB_ges(2); 0]; % Spalte 1
matG_ges = [matG_ges, [0; 0; 0; matB_ges(4); 0; 1]]; % Spalte 2



