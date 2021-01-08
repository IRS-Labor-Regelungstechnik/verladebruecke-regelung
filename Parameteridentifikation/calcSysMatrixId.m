function [matA, matB, matC, matD, matK, X0] = calcSysMatrixId(par, ts, aux)
% Laufkatzenteilsystem ohne Winkel

T_K = par(1);
R = aux(1);
ue = aux(2);
K_K = aux(3);

matA = [0 1;
        0 -(T_K^-1)];
matB = [0; (2*pi*R*K_K)/(ue*T_K)];
matC = [1 0];
matD = [0];

X0 = [0; 0];
matK = [0; 0];

end