%
% pt4-Glied Berechnung
%

%% Parameter
tau = 0.85;

%%
T1 = tau;
T2 = tau;
T3 = tau;
T4 = tau;


s4 = T1*T2*T3*T4;
s3 = (T1*T3*T4) + (T2*T3*T4) + (T1*T2*T4) + (T1*T2*T3);
s2 = (T1*T2) + (T1*T3) + (T1*T4) + (T2*T3) + (T2*T4) + (T3*T4);
s1 = T1+T2+T3+T4;
s0 = 1;