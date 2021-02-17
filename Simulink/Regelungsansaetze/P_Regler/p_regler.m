% Needs modell_parameter.m, system_linearisierung.m

dot_u_max = 9.57 / 75;  % max 1/s devided by 75 1/Vs
t = 0:0.01:30;
u_max = dot_u_max * t;

% ramp response when u = u_max
[max_u_resp, t_u_max] = step(G_1 * dot_u_max / tf('s'), 0:0.01:1.2);


% Laufkatze step response
R_1 = 0.01;

F_ox = R_1 * G_1;
cl_x = F_ox / (1+F_ox);

[x_resp, ~] = step(cl_x, t);



% K_R = 0.01;
% T_R = 2;
% T_N = 1;
% 
% R_1 = K_PK;
% R_3 = tf(K_R*[T_R, 1], [T_N, 1]);
% 
% F_o = R_1 / (1 - R_3 * G_3);
% 
% F_o2 = G_1 / (1 - R_3 * G_3);
% 
% G_w1 = (F_o * G_1) / (1 + F_o * G_1);
% G_w3 = (F_o * G_3) / (1 + F_o * G_3);

plot(t_u_max, max_u_resp, t, x_resp)