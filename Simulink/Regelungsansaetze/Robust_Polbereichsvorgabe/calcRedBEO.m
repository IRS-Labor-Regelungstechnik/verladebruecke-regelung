%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% berechne reduzierten Beobachter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% f�hre zuerst calc_regler_polbereichsvorgabe aus um die ben�tigten
% Parameter in den Workspace zu laden

%% berechne Systemmatrizen

sys = system;
sys.L = system.currL;
[matA_g, matB_g, ~, ~, ~] = calcSysMatrixBEO(sys);

%% St�rgr��enaufschaltung
% berechne Matrizen f�r St�rgr��enaufschaltung
[~, ~, ~, matB, matE] = calcSysMatrixBEO(sys);

%% Umordnung der Zust�nde

% Messgr��en: 1, Sensorkoordinaten: 0
% BEO f�r St�rgr��e und Geschwindigkeit
messgroessen = [1, 0, 0];
% BEO f�r St�rgr��e
% messgroessen = [1, 1, 0];
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

% BEO f�r St�rgr��e und Geschwindigkeit
ew1_2 = -100; % Eigenwerte des BEO

l1 = 2*(-1*ew1_2)-10;
l2 = (ew1_2^2)/A_22(1,2);

matL = [l1;
        l2];

% BEO f�r St�rgr��e
% ew = -50; % Eigenwerte des BEO
% 
% l1 = 0;
% l2 = -1*ew/A_12(2);
% 
% matL = [l1 l2];

