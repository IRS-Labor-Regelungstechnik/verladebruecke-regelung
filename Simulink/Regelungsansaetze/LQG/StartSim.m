clear all

%% Parameters

L_0 = 0.6;
x_0 = 1.3;
phi_0 = 0;
g = 9.81;
T1 = 0.03032;
T2 = 0.03032;
K1 = 1;
K2 = 1;
r1 = 0.046;
r2 = 0.025;
ue1 = 6;
ue2 = 3;

%% Linearized System

L=1.3;

%Laufkatze
a22 = -1/T1;
a42 = 1/(L*T1);
a43 = -g/L;

b2 = 2*pi*K1*r1/(ue1*T1);
b4 = -2*K1*pi*r1/(ue1*T1);

A1=[0 1 0 0;
   0 a22 0 0;
   0 0 0 1;
   0 a42 a43 0];
B1=[0 b2 0 b4]';
C1=[1 0 0 0 ; 0 0 1 0];
D1=0;

%Hubmotor
A2=[0 1 ; 0 -1/T2];
B2=[0  2*pi*r2*K2/(ue2*T2)]';
C2=[1 0];
D2=0;

%Erweitertes System mit Stoermodell
E = [0.5 1 0 0]';
A_s = 0;
C_s = 1;

Ak = [A1                      E*C_s;
      zeros(1,size(A1,2))     A_s];

Bk = [B1; zeros(1,size(B1,2))];

Ck = [C1 zeros(size(C1,1),1)];

%% define the objective function
disp('objective function')
Q=[100 0 0 0;
    0 1 0 0;
    0  0 100 0;
    0  0 0 1];
R=0.1;

%% calculation of the solution of the riccati equation and the controller
%% gain
disp('P, L(Eigenwerte) and K:')
[P,L,K] = care(A1,B1,Q,R,zeros(size(B1)),eye(size(A1)))

%% Simulation
te=30;  %simulation time

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
%% run the simulink model
sim('nichtlinearesModell',te)

%% plot

figure(1)
subplot(5,1,1)
plot(tout(1:length(u)),u(:,1))
ylabel('u_{1}=n_{weg}')

subplot(5,1,2)
plot(tout(1:length(x)),x(:,1))
ylabel('x_{1}=x')

subplot(5,1,3)
plot(tout(1:length(x)),x(:,2))
ylabel('x_{2}=x^°')

subplot(5,1,4)
plot(tout(1:length(x)),x(:,3))
ylabel('x_6=phi')

subplot(5,1,5)
plot(tout(1:length(x)),x(:,4))
ylabel('x_5=phi^°')
xlabel('t [s]')