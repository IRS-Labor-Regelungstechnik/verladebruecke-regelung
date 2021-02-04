%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% berechne Kalmanfilter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% führe zuerst calc_regler_polbereichsvorgabe aus um die benötigten
% Parameter in den Workspace zu laden

%% Störgrößenaufschaltung
% berechne Matrizen für Störgrößenaufschaltung
sys = system;
[~, ~, ~, matB, matE] = calcSysMatrixKleinStoer(sys);

%% berechne Kalman-Filter

% Kovarianz
matR_ges = diag([1; 1]); % Kovarianzmatrix Ausgangsrauschen
matQ_ges = diag([5; 15]); % Kovarianzmatrix Systemrauschen

% Systemrauschen
% Annahme: wird bei der Übertragung der Solldrehzahl von der dSpace Box zum
% Umrichter in die Eingangsgröße eingekoppelt, in die Störgrößen wird dabei
% ebenfalls ein Rauschen eingekoppelt
[~, matB_ges, ~, ~, ~, ~, ~] = calcSysMatrixStoer(sys);
matG_ges = [matB_ges; matB_ges(2); 0]; % Spalte 1
matG_ges = [matG_ges, [0; 0; 0; matB_ges(4); 0; 1]]; % Spalte 2



