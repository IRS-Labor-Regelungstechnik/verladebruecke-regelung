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
matR_ges = diag([1; 1]); % Kovarianzmatrix Ausgangsrauschen % TODO
matQ_ges = 5; % Kovarianzmatrix Eingangsrauschen % TODO

% Eingangsrauschen
% Annahme: wird bei der �bertragung der Solldrehzahl von der dSpace Box zum
% Umrichter in die Eingangsgr��e eingekoppelt, in die St�rgr��e wird dabei
% ebenfalls ein Rauschen eingekoppelt
[~, matB_ges, ~, ~, ~, ~, ~] = calcSysMatrixStoer(sys);
matG_ges = [matB_ges; matB_ges(2); 0];



