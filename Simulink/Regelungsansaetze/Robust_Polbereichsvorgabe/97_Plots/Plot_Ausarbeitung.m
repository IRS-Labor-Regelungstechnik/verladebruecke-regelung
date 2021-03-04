%
% Analyse Skript für PBVG Regler
%

%% Parameter

sys = system;

%% zu variierende Parameter

theta1_lb = 0.01; % L upper bound
theta1_ub = 1.65; % L lower bound
system.theta1 = theta1_lb:0.01:theta1_ub;

theta2_lb = 0.03032; % T_K upper bound
theta2_ub = 0.03032; % T_K lower bound
system.theta2 = theta2_lb:0.001:theta2_ub;

%% Berechne Pole

lambda_ges = [];
for m = 1:size(system.theta1,2)
    for j = 1:size(system.theta2,2)
    
    sys = system;
    
    % variiernder Parameter
    sys.L = system.theta1(m);
    sys.T_K = system.theta2(j);
    
    % Berechne Matrizen des Gesamtsystems
    [A, B, C] = calcSysMatrix(sys);
    
    % Rückführung auf konstante Ausgangsrückführung siehe BB RLM 7.2
    A_g = [A,                   zeros(size(A,1),1);
        zeros(1,size(A,2)),  0];
    B_g = [B,                   zeros(size(B,1),1);
        zeros(1,size(B,2)),  1];
    C_g = [C,                   zeros(size(C,1),1);
        zeros(1,size(C,2)),  1];
    
    K_g = [x(1), x(2), x(3);
        x(4), x(5), x(6)];
    
    % berechne Eigenwerte des neuen Systems
    lambda = eig(A_g - (B_g * K_g * C_g));
    lambda_ges = [lambda_ges; lambda];
    
    
    end
end

a_P = 0.1;
b_P = 1;
R_P = 43;

P = 1000;

eta_kreis = -43:0.01:5;
omega_kreis = sqrt(abs(R_P^2 - eta_kreis.^2));

eta_hyp = -5:0.01:-0.1;
omega_hyp = sqrt(abs(((-1).*eta_hyp.*(b_P/a_P)).^2-b_P^2));

%% farben definieren
% grün und gelb vertauscht
co = [0      0.4470 0.7410; % blau
      0.8500 0.3250 0.0980; % rot
      0.4660 0.6740 0.1880; % grün
      0.8500 0.3250 0.0980; % rot
      0.4660 0.6740 0.1880; % grün
      0.3010 0.7450 0.9330; % hellblau
      0.6350 0.0780 0.1840]; % dunkelrot
set(groot,'defaultAxesColorOrder',co)

figure('Units', 'normalized', 'Position',[0.1, 0.1, 0.5, 0.5]);
plot(lambda_ges, 'x')
hold on
plot(eta_kreis+(omega_kreis.*1i), '-')
plot(eta_hyp+(omega_hyp.*1i), '-')

plot(eta_kreis-(omega_kreis.*1i), '-')
plot(eta_hyp-(omega_hyp.*1i), '-')

legend('Eigenwerte', 'linke Grenze Polbereich', 'rechte Grenze Polbereich', 'Location', 'northwest')
xlabel('Im(lambda)')
ylabel('Re(lambda)')

matlab2tikz('ew_polbereich_robust.tex')

