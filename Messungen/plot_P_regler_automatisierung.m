data = load('P-Regler-mit-Butter.mat');
data = data.P_Regler_mit_Butter;

t = data.X.Data;

relevant_data = ...
    [ ...
    4, ... % angle 
    6, ... % angle_speed
    8, ... % horiz_pos
    9, ... % horiz_speed
    10, ... % magnet
    11, ... % regler an
    12, ... % vert_pos
    13, ... % vert_speed
    15, ... % x_soll
    18, ... % y_soll
    ];

ylab = ['\vartheta', '\dot \vartheta', '\dot y_1', 'Magnet', '\dot y_2', 'Sollwert y_1', 'Sollwert y_2'];
legends = {'Winkelausschlag', 'Winkelgeschw', 'Laufkgeschw', 'Magnet', 'Hubmotorgeschw', 'Sollwert y_1', 'Sollwert y_2'};

%% X Soll und Pos
figure(1)
plot(t, data.Y(15).Data, t, data.Y(8).Data, t, 0.995*data.Y(10).Data, t, data.Y(11).Data);
leg = legend('Sollwert Weg $y_1$', 'Istwert Weg $y_1$', 'Magnet', 'Regler aktiv');
leg.Interpreter = 'latex';
leg.Location = 'south';
lab = xlabel('$t$ [s]');
lab.Interpreter = 'latex';
lab = ylabel('[V]');
lab.Interpreter = 'latex';

%% Y Soll und Pos
figure(2)
ax=axes; 
plot(t, data.Y(18).Data, t, data.Y(12).Data, t, 0.995*data.Y(10).Data, t, data.Y(11).Data);
leg = legend('Sollwert Hub $y_2$', 'Istwert Hub $y_2$', 'Magnet', 'Regler aktiv');
leg.Interpreter = 'latex';
leg.Location = 'south';
lab = xlabel('$t$ [s]');
lab.Interpreter = 'latex';
lab = ylabel('[V]');
lab.Interpreter = 'latex';


%% Winkel
%figure(3)
%plot(t, data.Y(4).Data,  t, 10* data.Y(9).Data,  t, 10* data.Y(13).Data);
%leg = legend('Winkelausschlag $y_3$', 'Laufkatzengeschw. $\dot y_1$', 'Hubmotorgeschw. $\dot y_2$');
%leg.Interpreter = 'latex';
