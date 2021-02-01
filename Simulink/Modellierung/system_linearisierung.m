A = @(L_0) [0, 1, 0, 0;
            0, -1/param.T_K, 0, 0;
            0, 0, 0, 1;
            0, 1/(param.T_K*L_0), -9.81/L_0, 0];
B = @(L_0) [0; 
            param.eta_K; 
            0; 
            -param.eta_K/param.L_0];
C = [param.k_AWG_K, 0,0 ,0;
     0, 0, 360/(2*pi), 0];

% L_0 = 0.5m
A_05 = A(0.5);
B_05 = B(0.5);
% C ist von der L?nge unabh?ngig! 
% D ist sowieso null

% L_0 = 1m
A_1 = A(1);
B_1 = B(1);

transfunc.Y_1_numer = [param.k_AWG_K * param.eta_K];
transfunc.Y_1_denom = [1, 1/param.T_K 0];
G_1 = tf(transfunc.Y_1_numer, transfunc.Y_1_denom);

transfunc.Y_3_numer = [-param.eta_K*param.T_K, 0];
transfunc.Y_3_denom = [param.T_K, param.L_0, 9.81*param.T_K, 9.81];
G_3 = tf(transfunc.Y_3_numer, transfunc.Y_3_denom);

