%% parameter for the model
assignin('base', 'T1',0.05)
assignin('base', 'K1',1)
assignin('base', 'r1',0.05)
assignin('base', 'ue1',6)

assignin('base', 'T2',0.05)
assignin('base', 'K2',1)
assignin('base', 'r2',0.05)
assignin('base', 'ue2',3)

%% Input
%Spannung
assignin('base', 'u1',0.5)
assignin('base', 'u2',0)
%Dauer
assignin('base', 't1',3)
assignin('base', 't2',0)

%% run the simulink model
sim nichtlinearesModell

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
ylabel('x_{2}=x^°')

subplot(8,1,5)
plot(tout,x(:,3))
ylabel('x_{3}=L')

subplot(8,1,6)
plot(tout,x(:,4))
ylabel('x_{4}=L^°')

subplot(8,1,7)
plot(tout,x(:,5))
ylabel('x_6=phi')

subplot(8,1,8)
plot(tout,x(:,6))
ylabel('x_5=phi^°}')
xlabel('t [s]')