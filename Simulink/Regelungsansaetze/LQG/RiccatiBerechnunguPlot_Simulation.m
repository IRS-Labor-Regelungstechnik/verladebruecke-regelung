
%% Parameters

L_0 = 0.5;
x_0 = 2.54;
phi_0 = 0;
g = 9.81;
T1 = 0.03032;
T2 = 0.0247;
K1 = 1;
K2 = 1;
r1 = 0.046;
r2 = 0.021975;
ue1 = 6;
ue2 = 3;

%% Linearized System

L=0.5;

%Laufkatze
a22 = -1/T1;
a42 = 1/(L*T1);
a43 = -g/L;

b2 = 2*pi*K1*r1/(ue1*T1);
b4 = -2*K1*pi*r1/(ue1*T1*L);

A1=[0 1 0 0;
   0 a22 0 0;
   0 0 0 1;
   0 a42 a43 0];
B1=[0 b2 0 b4]';
C1=[1 0 0 0 ; 0 0 1 0];
D1=0;

%Erweitertes System Laufkatze mit Stoermodell
%Spannungoffset Umrichter
E1 = B1;
A1_s = 0;
C1_s = 1;

A1s = [A1                     E1*C1_s;
      zeros(1,size(A1,2))     A1_s];

B1s = [B1; zeros(1,size(B1,2))];

C1s = [C1 zeros(size(C1,1),1)];

%Winkeloffset
E_w = [0; 0; 0; 0; 0]; % kein Einfluss auf Zustände, da Winkeloffset erst am Ausgang wirkt
A_w = 0; % stückweise konstant
C_w = 1;


% Gesamtmodell
A1k = [A1s                     E_w*C_w;
       zeros(1,size(A1s,2))    A_w];

B1k = [B1s; zeros(1,size(B1s,2))];

C1k = [C1s [0; 1]]; % nicht wie in bsw. RLM mit Nullen aufgefüllt (s.o.), da Störung erst am Ausgang wirkt

D1k = [0; 0];

%Hubmotor
A2=[0 1 ; 0 -1/T2];
B2=[0  pi*r2*K2/(ue2*T2)]';
C2=[1 0];

%Erweitertes System Hubmotor mit Stoermodell
E2 = B2;
A2_s = 0;
C2_s = 1;

A2k = [A2                     E2*C2_s;
      zeros(1,size(A2,2))     A2_s];

B2k = [B2; zeros(1,size(B2,2))];

C2k = [C2 zeros(size(C2,1),1)];

%% Kalman-Filter

% Laufkatze
R1k = diag([1 30]); % Kovarianzmatrix Messrauschen
Q1k = diag([30 5]); % Kovarianzmatrix Systemrauschen

G1k = B1k + [0 0 0 0 B1k(2) 0]';
G1k = [G1k [0 0 0 B1k(4) 0 1]'];

%Hubmotor
R2k = 10000; % Kovarianzmatrix Messrauschen
Q2k = 0.01; % Kovarianzmatrix Systemrauschen

G2k= B2k + [0 0 B2k(2)]';

%% define the objective function
disp('objective function')
Q=[100 0 0 0;
    0 1 0 0;
    0  0 1 0;
    0  0 0 1];
R=0.3;

%% calculation of the solution of the riccati equation and the controller
%% gain
disp('P, L(Eigenwerte) and K:')
[P,L,K] = care(A1,B1,Q,R,zeros(size(B1)),eye(size(A1)))

%% Simulation
te=250;  %simulation time

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

assignin('base', 'start',0)

%% run the simulink model
sim('Riccati_Simulation',te)

%% plot

figure(1)
subplot(5,1,1)
plot(tout(1:length(u)),u(:,1))
ylabel('u_{1}=n_{weg}')

subplot(5,1,2)
plot(tout(1:length(x)),x(:,1))
ylabel('x_{1}=x]')

subplot(5,1,3)
plot(tout(1:length(x)),x(:,2))
ylabel('x_{2}=x^° ')

subplot(5,1,4)
plot(tout(1:length(x)),x(:,3))
ylabel('x_3=phi')

subplot(5,1,5)
plot(tout(1:length(x)),x(:,4))
ylabel('x_4=phi^°')
xlabel('t [s]')

figure(2)
subplot(3,1,1)
plot(tout(1:length(u)),u(:,2))
ylabel('u_{2}=n_{hub}')

subplot(3,1,2)
plot(tout(1:length(x)),x(:,5))
ylabel('x_5=L')

subplot(3,1,3)
plot(tout(1:length(x)),x(:,6))
ylabel('x_6=L^°')
xlabel('t [s]')