function [matA_g, matB_g, matC_g, matB, matE] = calcSysMatrixHubStoer(sys)
% berechne die Systemmatrizen der Laufkatze ohne Winkeldynamik inklusive
% St�rmodell
% wird f�r die Berechnung des reduzierten BEO und die 
% St�rgr��enaufschaltung ben�tigt

matA = [0 1;
        0 -(sys.T_G^-1)];

matB = [0; sys.eta];

matC = [sys.k_AWG 0];

% Einfluss der St�rung auf Zust�nde
matE = matB;

% St�rmodell
matA_s = 0;

matC_s = 1;

% Gesamtmodell
matA_g = [matA                      matE*matC_s;
          zeros(1,size(matA,2))     matA_s];

matB_g = [matB; zeros(1,size(matB,2))];

matC_g = [matC zeros(size(matC,1),1)];

end