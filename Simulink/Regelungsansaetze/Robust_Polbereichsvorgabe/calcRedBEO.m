%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% berechne reduzierten Beobachter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% führe zuerst calc_regler_polbereichsvorgabe aus um die benötigten
% Parameter in den Workspace zu laden

%% berechne Systemmatrizen

sys = system;
sys.L = system.currL;
[matA_g, matB_g, ~, ~, ~] = calcSysMatrixBEO(sys);

%% Störgrößenaufschaltung
% berechne Matrizen für Störgrößenaufschaltung
[~, ~, ~, matB, matE] = calcSysMatrixBEO(sys);

%% Umordnung der Zustände

% Messgrößen: 1, Sensorkoordinaten: 0
messgroessen = [1, 0, 0];
numMessg = sum(messgroessen);

% Umordnung der Zeilen
matA_g_temp = zeros(size(matA_g,1),size(matA_g,2));
matB_g_u = zeros(size(matB_g,1),size(matB_g,2));
counterM = 0;
counterS = 0;
for i = 1:size(messgroessen, 2)
    if messgroessen(1,i) == 1
        counterM = counterM+1;
        matA_g_temp(counterM,:) = matA_g(i,:);
        matB_g_u(counterM) = matB_g(i);
    else
        counterS = counterS+1;
        matA_g_temp(numMessg+counterS,:) = matA_g(i,:);
        matB_g_u(numMessg+counterS) = matB_g(i);
    end
end

% Umordnung der Spalten
matA_g_u = zeros(size(matA_g,1),size(matA_g,2));
counterM = 0;
counterS = 0;
for j = 1:size(messgroessen, 2)
    if messgroessen(1,j) == 1
        counterM = counterM+1;
        matA_g_u(:,counterM) = matA_g_temp(:,j);
    else
        counterS = counterS+1;
        matA_g_u(:,numMessg+counterS) = matA_g_temp(:,j);
    end
end

%% Aufteilen der Matrizen

A_11 = matA_g_u(1:numMessg,1:numMessg);
A_12 = matA_g_u(1:numMessg,numMessg+1:end);
A_21 = matA_g_u(numMessg+1:end,1:numMessg);
A_22 = matA_g_u(numMessg+1:end,numMessg+1:end);

B_1 = matB_g_u(1:numMessg);
B_2 = matB_g_u(numMessg+1:end);

%% Berechne L
% Entwurf mittels Polvorgabe
% alle EW bei -10

matL = [10;
        207.5980901];

