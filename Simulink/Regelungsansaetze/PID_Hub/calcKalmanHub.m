%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% berechne Kalmanfilter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% führe zuerst clalcPIDHub aus um die benötigten
% Parameter in den Workspace zu laden

%% berechne Systemmatrizen

sys = systemhub;
[matA_hub_g, matB_hub_g, matC_hub_g, ~, ~] = calcSysMatrixHubStoer(sys);

%% Störgrößenaufschaltung
% berechne Matrizen für Störgrößenaufschaltung
[~, ~, ~, matB_hub, matE_hub] = calcSysMatrixHubStoer(sys);

%% berechne Kalman-Filter

% Kovarianz
matR_hub = 10000; % Kovarianzmatrix Ausgangsrauschen % TODO
matQ_hub = 0.1; % Kovarianzmatrix Eingangsrauschen % TODO

% Eingangsrauschen
% Annahme: wird bei der Übertragung der Solldrehzahl von der dSpace Box zum
% Umrichter in die Eingangsgröße eingekoppelt, in die Störgröße wird dabei
% ebenfalls ein Rauschen eingekoppelt
matG_hub = matB_hub_g + [0; 0; matB_hub_g(2)];

% % berechne Kalman-Filter Matrix
% [matP, ~, ~] = care(matA_g', matC_g', matG*matQ*matG', matR);
% matK = matP * matC_g' / matR;


