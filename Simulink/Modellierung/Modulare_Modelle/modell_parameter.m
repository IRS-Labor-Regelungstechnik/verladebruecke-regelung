%% Parameters

L_0 = 0.2;
x_0 = 0;
phi_0 = 0;
g = 9.81;
T1 = 0.05;
T2 = 0.05;
r1 = 0.05;
r2 = 0.05;
ue1 = 6;
ue2 = 3;
st1 = 0.1;
d = 0.02;  % Daempfung

%% Input

%Spannung
assignin('base', 'u1',0.1)
assignin('base', 'u2',0.1)
%Start
assignin('base', 't01',0)
assignin('base', 't02',5)
%Ende
assignin('base', 't1',5)
assignin('base', 't2',8)

%% Nonlinear Model

assignin('base', 'T1',T1)
assignin('base', 'r1',r1)
assignin('base', 'ue1',ue1)

assignin('base', 'T2',T2)
assignin('base', 'r2',r2)
assignin('base', 'ue2',ue2)

assignin('base', 'L_0',L_0)
assignin('base', 'x_0',x_0)
assignin('base', 'phi_0',phi_0)
