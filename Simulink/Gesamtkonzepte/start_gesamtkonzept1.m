%% Parameters

L_0 = 0.2;
x_0 = 0;
phi_0 = 0;
g = 9.81;
T1 = 0.05;
T2 = 0.05;
K1 = 1;
K2 = 1;
r1 = 0.05;
r2 = 0.05;
ue1 = 6;
ue2 = 3;

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
assignin('base', 'K1',K1)
assignin('base', 'r1',r1)
assignin('base', 'ue1',ue1)

assignin('base', 'T2',T2)
assignin('base', 'K2',K2)
assignin('base', 'r2',r2)
assignin('base', 'ue2',ue2)

assignin('base', 'L_0',L_0)
assignin('base', 'x_0',x_0)
assignin('base', 'phi_0',phi_0)

%% Linearized System

L=0.2;

%Laufkatze
a22 = -1/T1;
a42 = 1/(L*T1);
a43 = -g/L;

b2 = 2*pi*r1/(ue1*T1);
b4 = -2*pi*r1/(ue1*T1);

A1=[0 1 0 0;
   0 a22 0 0;
   0 0 0 1;
   0 a42 a43 0];
B1=[0 b2 0 b4]';
C1=eye(4);
D1=[0 0 0 0]';

%Hubmotor
A2=[0 1 ; 0 -1/T2];
B2=[0  2*pi*r2*K2/(ue2*T2)]';
C2=eye(2);
D2=[0 0]';

%% run the simulink model

sim gesamtkonzept1
%sim linearesModell

%% plot

figure(1)

subplot(8,1,1)
plot(tout,u(:,1))
ylabel('u_{1}=n_{weg}')

subplot(8,1,2)
plot(tout,u(:,2))
ylabel('u_{1}=n_{hub}')

subplot(8,1,3)
plot(tout,x(:,1))
ylabel('x_{1}=x')

subplot(8,1,4)
plot(tout,x(:,2))
ylabel('x_{2}=x^?')

subplot(8,1,5)
plot(tout,x(:,3))
ylabel('x_{3}=L')

subplot(8,1,6)
plot(tout,x(:,4))
ylabel('x_{4}=L^?')

subplot(8,1,7)
plot(tout,x(:,5))
ylabel('x_6=phi')

subplot(8,1,8)
plot(tout,x(:,6))
ylabel('x_5=phi^?')
xlabel('t [s]')