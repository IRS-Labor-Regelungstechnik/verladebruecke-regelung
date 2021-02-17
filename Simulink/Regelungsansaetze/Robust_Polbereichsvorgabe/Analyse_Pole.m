%
% Analyse Skript für PBVG Regler
%

%% Parameter

sys = system;

%% zu variierende Parameter

theta1_lb = 0.03; % L upper bound
theta1_ub = 1.5; % L lower bound
system.theta1 = theta1_lb:0.01:theta1_ub;

theta2_lb = 0.03032; % T_K upper bound
theta2_ub = 0.03032; % T_K lower bound
system.theta2 = theta2_lb:0.001:theta2_ub;

%% Berechne Pole

lambda_ges = [];
for i = 1:size(system.theta1,2)
    for j = 1:size(system.theta2,2)
    
    sys = system;
    
    % variiernder Parameter
    sys.L = system.theta1(i);
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
    
    
%     sys = ss([A_g - (B_g * K_g * C_g)], [1;0;0;0;0], [1 0 0 0 0; 0 1 0 0 0; 0 0 1 0 0; 0 0 0 1 0; 0 0 0 0 1], 0);
%     sys = canon(sys,'modal');
%     %EW
%     for k = 1:5
%         for j_sig = 1:1 % Eingänge
%             for i_sig = 1:5 % Ausgänge bzw. Zustände 5.: Zustand des Reglers
%                 temp = abs(sys.C(i_sig,k) * sys.B(k,j_sig) / lambda(k));
%                 
%                 
%             end
%             
%         end
%         
%     end
    
    end
end

plot(lambda_ges, 'x')
hold on
%plot([-16.27-33.29i; -4.33-23.72i; -12.53-31.19i; -1.599-10.28i; -1.118-1.057i], 'o')
%hold off





