function [matA, matB, matC] = calcSysMatrix(sys)

matA = [0 1                     0                   0;
        0 -(sys.T_K^-1)         0                   0;
        0 0                     0                   1;
        0 (sys.T_K*sys.L)^-1    -sys.g*(sys.L^-1)   0];

matB = [0; (2*pi*sys.R*sys.K_K)/(sys.ue*sys.T_K); 0; (-2*pi*sys.R*sys.K_K)/(sys.ue*sys.T_K*sys.L)];

matC = [1 0 0 0; 0 0 1 0];

end