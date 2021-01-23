%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% berechne Kalmanfilter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% f�hre zuerst calc_regler_polbereichsvorgabe aus um die ben�tigten
% Parameter in den Workspace zu laden

%% berechne Systemmatrizen

sys = system;
[matA_g, matB_g, matC_g, ~, ~] = calcSysMatrixKleinStoer(sys);

%% St�rgr��enaufschaltung
% berechne Matrizen f�r St�rgr��enaufschaltung
[~, ~, ~, matB, matE] = calcSysMatrixKleinStoer(sys);

%% berechne Kalman-Filter

% Kovarianz
matR = 1; % Kovarianzmatrix Ausgangsrauschen % TODO
matQ = 50; % Kovarianzmatrix Eingangsrauschen % TODO

% Eingangsrauschen
% Annahme: wird bei der �bertragung der Solldrehzahl von der dSpace Box zum
% Umrichter in die Eingangsgr��e eingekoppelt, in die St�rgr��e wird dabei
% ebenfalls ein Rauschen eingekoppelt
matG = matB_g + [0; 0; matB_g(2)];

% berechne Kalman-Filter Matrix
[matP, ~, ~] = care(matA_g', matC_g', matG*matQ*matG', matR);
matK = matP * matC_g' / matR;


