%% define the linearized system:
disp('system:')
l = 10;
g = 9.81;
T1 = 0.1;
T2 = 0.1;
r1 = 0.0191;
r2 = 0.015915;

a22 = -1/T1;
a42 = 1/(l*T1);
a43 = -g/l;

b2 = 2*pi*r1/(6*T1);
b4 = -2*pi*r1/(6*T1);

A=[0 1 0 0;
   0 a22 0 0;
   0 0 0 1;
   0 a42 a43 0];
B=[0 b2 0 b4]';

%% define the objective function
disp('objective function')
Q=[100 0 0 0;
    0 100 0 0;
    0  0 10 0;
    0  0 0 10];
R=0.1;

%% calculation of the solution of the riccati equation and the controller
%% gain
disp('P and K:')
[P,L,K] = care(A,B,Q,R,zeros(size(B)),eye(size(A)))

%% simulation
te=15;  %simulation time

assignin('base', 'T1',0.1)
assignin('base', 'k1',0.9)
assignin('base', 'n01',0)
assignin('base', 'r1',0.0191)

assignin('base', 'T2',0.1)
assignin('base', 'k2',0.9)
assignin('base', 'n02',0)
assignin('base', 'r2',0.015915)

sim('PT1sys',te)

figure(1)

subplot(5,1,1)
plot(tout,x(:,1))
ylabel('x_{1}=x')

subplot(5,1,2)
plot(tout,x(:,2))
ylabel('x_{2}=x^°')

subplot(5,1,3)
plot(tout,x(:,3))
ylabel('x_{3}=phi')

subplot(5,1,4)
plot(tout,x(:,4))
ylabel('x_{4}=phi^°')

subplot(5,1,5)
plot(tout(1:length(u)),u)
ylabel('u=n_{soll}')
xlabel('t [s]')




