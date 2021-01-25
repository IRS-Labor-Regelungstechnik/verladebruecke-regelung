%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% berechne Kalmanfilter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% führe zuerst calc_regler_polbereichsvorgabe aus um die benötigten
% Parameter in den Workspace zu laden

%% berechne Systemmatrizen

sys = system;
[~, ~, ~, ~, matA_gross, matB_gross, matC_gross] = calcSysMatrixStoer(sys);

%% berechne Kalman-Filter

% Kovarianz
matR_gross = [1 0; 0 1]; % Kovarianzmatrix Ausgangsrauschen % TODO
matQ_gross = 50; % Kovarianzmatrix Eingangsrauschen % TODO

% Eingangsrauschen
% Annahme: wird bei der Übertragung der Solldrehzahl von der dSpace Box zum
% Umrichter in die Eingangsgröße eingekoppelt, in die Störgröße wird dabei
% ebenfalls ein Rauschen eingekoppelt
matG_gross= matB_gross + [0; 0; 0; 0; matB_gross(2)];

% berechne Kalman-Filter Matrix
% [matP, ~, ~] = care(matA_g', matC_g', matG*matQ*matG', matR);
% matK = matP * matC_g' / matR;


