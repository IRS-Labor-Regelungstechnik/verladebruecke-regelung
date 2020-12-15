function [J] = guetemass(x, a_P, b_P, R_P, P, system)

J = 0;

% Summe über alle Modelle
for i = 1:size(system.theta,2)
    
    sys = system;
    sys.L = system.theta(i);
    
    [A, B, C, ~, ~] = calcSysMatrix(sys);
    
    % Rückführung auf konstante Ausgangsrückführung siehe BB RLM 7.2
    A_g = [A,                   zeros(size(A,1),1);
           zeros(1,size(A,2)),  0];
    B_g = [B,                   zeros(size(B,1),1);
           zeros(1,size(B,2)),  1];
    C_g = [C,                   zeros(size(C,1),1);
           zeros(1,size(C,2)),  1];
    
    K_g = [x(1), x(2), x(3), x(4);
           x(5), x(6), x(7), x(8)];
    
    % berechne Eigenwerte des neuen Systems 
    lambda = eig(A_g - (B_g * K_g * C_g));
    
    % Summe über Straffunktionen der einzelnen Eigenwerte
    gamma_sum = 0;
    for k = 1:size(lambda,1)
        
        eta = real(lambda(k));
        omega = imag(lambda(k));
        
        % berechne Straffunktion
        gamma_sum = gamma_sum ...
                    + exp(P * (eta + ((a_P/b_P) * sqrt(b_P^2 + omega^2)))) ...
                    + exp(P * (sqrt(eta^2 + omega^2) - R_P));
    end
    
    J = J + gamma_sum;
    
end


end