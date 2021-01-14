%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% berechne Kalmanfilter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% f�hre zuerst calc_regler_polbereichsvorgabe aus um die ben�tigten
% Parameter in den Workspace zu laden

%% berechne Systemmatrizen

sys = system;
sys.L = system.currL;
% [matA, ~, matC] = calcSysMatrixKalman(sys); % matB wird untern berechnet
[matA_g, matB_g, matC_g, ~, ~] = calcSysMatrixBEO(sys);

%% St�rgr��enaufschaltung
% berechne Matrizen f�r St�rgr��enaufschaltung
[~, ~, ~, matB, matE] = calcSysMatrixBEO(sys);

%% berechne Kalman-Filter

% Kovarianz
matR = 1; % Kovarianzmatrix Ausgangsrauschen % TODO
matQ = 100; % Kovarianzmatrix Eingangsrauschen % TODO

% Eingangsrauschen
% Annahme: wird bei der �bertragung der Solldrehzahl von der dSpace Box zum
% Umrichter in die Eingangsgr��e eingekoppelt, in die St�rgr��e wird dabei
% ebenfalls ein Rauschen eingekoppelt
matG = matB_g + [0; 0; matB_g(2)];

% berechne Kalman-Filter Matrix
[matP, ~, ~] = care(matA_g', matC_g', matG*matQ*matG', matR);
matK = matP * matC_g' / matR;


