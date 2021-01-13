function [matA_g, matB_g, matC_g, matB, matE] = calcSysMatrixBEO(sys)
% berechne die Systemmatrizen der Laufkatze ohne Winkeldynamik inklusive
% Störmodell
% wird für die Berechnung des reduzierten BEO und die 
% Störgrößenaufschaltung benötigt

matA = [0 1;
        0 -(sys.T_K^-1)];

matB = [0; (2*pi*sys.R*sys.K_K)/(sys.ue*sys.T_K)];

matC = [1 0];

% Einfluss der Störung auf Zustände
matE = matB;

% Störmodell
matA_s = 0;

matC_s = 1;

% Gesamtmodell
matA_g = [matA                      matE*matC_s;
          zeros(1,size(matA,2))     matA_s];

matB_g = [matB; zeros(1,size(matB,2))];

matC_g = [matC zeros(size(matC,1),1)];

end