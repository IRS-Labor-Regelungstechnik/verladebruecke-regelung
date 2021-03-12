

data = load('robust_winkeltol_10.mat');
data = data.robust_winkeltol_10;

LEG_FONT_SIZE = 10;
LABEL_FONT_SIZE = 12;

linienstaerke = 1;

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
% figure
% 
% subplot(3,1,1);
% plot(t, data.Y(15).Data.*2.54, t, data.Y(8).Data.*2.54, 'Linewidth', linienstaerke);
% leg = legend('Sollwert $x_1$', 'Istwert $x_1$');
% leg.Interpreter = 'latex';
% leg.Location = 'southeast';
% leg.FontSize = LEG_FONT_SIZE;
% leg.Orientation = 'horizontal';
% 
% lab = xlabel('$t$ [s]');
% lab.FontSize = LABEL_FONT_SIZE;
% lab.Interpreter = 'latex';
% 
% lab = ylabel('Position [m]');
% lab.Interpreter = 'latex';
% lab.FontSize = LABEL_FONT_SIZE;
% 
% subplot(3,1,2);
% plot(t, data.Y(33).Data.*(360/(2*pi)), 'Linewidth', linienstaerke);
% leg = legend('Zustand $x_5$');
% leg.Interpreter = 'latex';
% leg.Location = 'southeast';
% leg.FontSize = LEG_FONT_SIZE;
% leg.Orientation = 'horizontal';
% 
% labx = xlabel('$t$ [s]');
% labx.FontSize = LABEL_FONT_SIZE;
% labx.Interpreter = 'latex';
% 
% laby = ylabel('Winkel [$^{\circ}$]');
% laby.FontSize = LABEL_FONT_SIZE;
% laby.Interpreter = 'latex';
% 
% subplot(3,1,3);
% plot(t, data.Y(36).Data.*(360/(2*pi)), 'Linewidth', linienstaerke);
% leg = legend('gesch{\"a}tzter Winkeloffset');
% leg.Interpreter = 'latex';
% leg.Location = 'southeast';
% leg.FontSize = LEG_FONT_SIZE;
% leg.Orientation = 'horizontal';
% 
% labx = xlabel('$t$ [s]');
% labx.FontSize = LABEL_FONT_SIZE;
% labx.Interpreter = 'latex';
% 
% laby = ylabel('Winkel [$^{\circ}$]');
% laby.FontSize = LABEL_FONT_SIZE;
% laby.Interpreter = 'latex';
% 
% saveas(gcf,'robuster_regler_katze_winkel.eps','epsc')

%% X Soll und Pos
figure

plot(t, (data.Y(18).Data.*1.375)+0.23, t, (data.Y(12).Data.*1.375)+0.23, 'Linewidth', linienstaerke);
leg = legend('Sollwert $x_3$', 'Istwert $x_3$');
leg.Interpreter = 'latex';
leg.Location = 'southeast';
leg.FontSize = LEG_FONT_SIZE;
leg.Orientation = 'horizontal';

lab = xlabel('$t$ [s]');
lab.FontSize = LABEL_FONT_SIZE;
lab.Interpreter = 'latex';

lab = ylabel('L{\"a}nge [m]');
lab.Interpreter = 'latex';
lab.FontSize = LABEL_FONT_SIZE;

saveas(gcf,'robuster_regler_greifer.eps','epsc')

