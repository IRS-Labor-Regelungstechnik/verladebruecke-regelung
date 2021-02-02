function [matA, matB, matC, matE, matA_g, matB_g, matC_g] = calcSysMatrixStoer(sys)
% Berechnung der Systemmatrizen des gesamten Systems inklusive des
% Störmodells des Spannungsoffset


matA = [0 1                     0                   0;
        0 -(sys.T_K^-1)         0                   0;
        0 0                     0                   1;
        0 (sys.T_K*sys.L)^-1    -sys.g*(sys.L^-1)   0];

matB = [0; (2*pi*sys.R*sys.K_K)/(sys.ue*sys.T_K); 0; (-2*pi*sys.R*sys.K_K)/(sys.ue*sys.T_K*sys.L)];

matC = [1 0 0 0; 0 0 1 0];

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