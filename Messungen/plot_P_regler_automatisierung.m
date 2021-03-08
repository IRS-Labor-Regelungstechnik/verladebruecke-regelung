data = load('P-Regler-mit-Butter.mat');
data = data.P_Regler_mit_Butter;

LEG_FONT_SIZE = 12;
LABEL_FONT_SIZE = 14;

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
leg = legend('Sollwert Laufkatzenpos.', 'Istwert Laufkatzenpos.', 'Magnet', 'Regler aktiv');
leg.Interpreter = 'latex';
leg.Location = 'south';
leg.FontSize = LEG_FONT_SIZE;
leg.Orientation = 'horizontal';

lab = xlabel('$t$ [s]');
lab.FontSize = LABEL_FONT_SIZE;
lab.Interpreter = 'latex';

lab = ylabel('[V]');
lab.Interpreter = 'latex';
lab.FontSize = LABEL_FONT_SIZE;

saveas(gcf,'P_regler_autom_X.eps','epsc')

%% Y Soll und Pos
figure(2)
ax=axes; 
plot(t, data.Y(18).Data, t, data.Y(12).Data, t, 0.995*data.Y(10).Data, t, data.Y(11).Data);
leg = legend('Sollwert Hubpos.', 'Istwert Hubpos.', 'Magnet', 'Regler aktiv');
leg.Interpreter = 'latex';
leg.Location = 'south';
leg.FontSize = LEG_FONT_SIZE;
leg.Orientation = 'horizontal';

lab = xlabel('$t$ [s]');
lab.Interpreter = 'latex';
lab.FontSize = LABEL_FONT_SIZE;

lab = ylabel('[V]');
lab.Interpreter = 'latex';
lab.FontSize = LABEL_FONT_SIZE;

saveas(gcf,'P_regler_autom_Y.eps','epsc')

%% Winkel
%figure(3)
%plot(t, data.Y(4).Data,  t, 10* data.Y(9).Data,  t, 10* data.Y(13).Data);
%leg = legend('Winkelausschlag $y_3$', 'Laufkatzengeschw. $\dot y_1$', 'Hubmotorgeschw. $\dot y_2$');
%leg.Interpreter = 'latex';
