%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% berechne Kalmanfilter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% führe zuerst calc_regler_polbereichsvorgabe aus um die benötigten
% Parameter in den Workspace zu laden

%% berechne Systemmatrizen

sys = system;
[matA_g, matB_g, matC_g, ~, ~] = calcSysMatrixKleinStoer(sys);

%% Störgrößenaufschaltung
% berechne Matrizen für Störgrößenaufschaltung
[~, ~, ~, matB, matE] = calcSysMatrixKleinStoer(sys);

%% berechne Kalman-Filter

% Kovarianz
matR = 1; % Kovarianzmatrix Ausgangsrauschen % TODO
matQ = 50; % Kovarianzmatrix Eingangsrauschen % TODO

% Eingangsrauschen
% Annahme: wird bei der Übertragung der Solldrehzahl von der dSpace Box zum
% Umrichter in die Eingangsgröße eingekoppelt, in die Störgröße wird dabei
% ebenfalls ein Rauschen eingekoppelt
matG = matB_g + [0; 0; matB_g(2)];

% berechne Kalman-Filter Matrix
[matP, ~, ~] = care(matA_g', matC_g', matG*matQ*matG', matR);
matK = matP * matC_g' / matR;


