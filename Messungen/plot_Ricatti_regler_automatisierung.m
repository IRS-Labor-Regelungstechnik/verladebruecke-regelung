% Die Messungen werden von Git ignoriert, da die Dateien einfach zu gro? sind. 
% Die Messung findet man unter: https://cloud.andrewdelay.com/index.php/s/FsTtRdeLLHWsP2p
% Im Ordner LR_dspace\ControlDesk_Gruppe2\Experiment_Gruppe2\Measurement Data
data = load('RiccatiRegler.mat');
data = data.RiccatiRegler;

LEG_FONT_SIZE = 10;
LABEL_FONT_SIZE = 12;

t = data.X.Data;

% Indizes von data.Y
% 1: horiz_pos 
% 2: ???
% 3: ???
% 4: winkel_speed
% 5: winkel
% 6: hub_speed echt oder gesch?tzt?
% 7: hub_speed echt oder gesch?tzt?
% 8: weg_speed echt oder gesch?tzt?
% 9: weg_speed echt oder gesch?tzt?
% 10:hub_pos
% 11:horiz_pos in Metern


plot(t, data.Y(1).Data)
error('Ende Index Test')

%% X Soll und Pos
figure(1)
%plot(t, data.Y(15).Data, t, data.Y(8).Data, t, 0.995*data.Y(10).Data, t, data.Y(11).Data);
%leg = legend('Sollwert $y_1$', 'Istwert $y_1$', 'Magnet', 'Regler aktiv');
plot(t, data.Y(15).Data, t, data.Y(8).Data, t, 0.995*data.Y(10).Data);
leg = legend('Sollwert $y_1$', 'Istwert $y_1$', 'Magnet');
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
% plot(t, data.Y(18).Data, t, data.Y(12).Data, t, 0.995*data.Y(10).Data, t, data.Y(11).Data);
% leg = legend('Sollwert $y_2$', 'Istwert $y_2$', 'Magnet', 'Regler aktiv');
plot(t, data.Y(18).Data, t, data.Y(12).Data, t, 0.995*data.Y(10).Data);
leg = legend('Sollwert $y_2$', 'Istwert $y_2$', 'Magnet');
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
