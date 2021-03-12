data = load('P-Regler-mit-Butter.mat');
data = data.P_Regler_mit_Butter;

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
figure(1)
%plot(t, data.Y(15).Data, t, data.Y(8).Data, t, 0.995*data.Y(10).Data, t, data.Y(11).Data);
%leg = legend('Sollwert $y_1$', 'Istwert $y_1$', 'Magnet', 'Regler aktiv');

rect_start = -1;
rect_on = false;
for i = 1:length(data.Y(10).Data)
    if data.Y(10).Data(i) == 1 && ~rect_on
        rect_start = i;
        rect_on = true;
    end
    if data.Y(10).Data(i) == 0 && rect_on
        rectangle('Position',[t(rect_start),0.01,t(i-rect_start),3],'FaceColor',[1, 1, 0.7], 'LineWidth', 1, 'EdgeColor', 'none')
        rect_on = false;
    end
end


hold on
plot(t, data.Y(15).Data .* 2.54, t, data.Y(8).Data .* 2.54); %, t, 0.995*data.Y(10).Data);

xlim([0, 320]);
ylim([0, 2.54]);

leg = legend('Sollposition', 'Istposition'); %, 'Magnet');
leg.Interpreter = 'latex';
leg.Location = 'south';
leg.FontSize = LEG_FONT_SIZE;
leg.Orientation = 'horizontal';

lab = xlabel('$t$ [s]');
lab.FontSize = LABEL_FONT_SIZE;
lab.Interpreter = 'latex';

lab = ylabel('Laufkatzenposition [m]');
lab.Interpreter = 'latex';
lab.FontSize = LABEL_FONT_SIZE;

saveas(gcf,'P_regler_autom_X.eps','epsc')

%% Y Soll und Pos
figure(2)
ax=axes; 
% plot(t, data.Y(18).Data, t, data.Y(12).Data, t, 0.995*data.Y(10).Data, t, data.Y(11).Data);
% leg = legend('Sollwert $y_2$', 'Istwert $y_2$', 'Magnet', 'Regler aktiv');

rect_start = -1;
rect_on = false;
for i = 1:length(data.Y(10).Data)
    if data.Y(10).Data(i) == 1 && ~rect_on
        rect_start = i;
        rect_on = true;
    end
    if data.Y(10).Data(i) == 0 && rect_on
        rectangle('Position',[t(rect_start),0.01,t(i-rect_start),2],'FaceColor',[1, 1, 0.7], 'LineWidth', 1, 'EdgeColor', 'none')
        rect_on = false;
    end
end

hold on
plot(t, data.Y(18).Data .* 1.37 + 0.23, t, data.Y(12).Data .* 1.37 + 0.23); %,t , 0.995*data.Y(10).Data);
ylim([0, 1.7])
xlim([0, 320]);

leg = legend('Sollposition', 'Istposition'); %, 'Magnet');
leg.Interpreter = 'latex';
leg.Location = 'south';
leg.FontSize = LEG_FONT_SIZE;
leg.Orientation = 'horizontal';

lab = xlabel('$t$ [s]');
lab.Interpreter = 'latex';
lab.FontSize = LABEL_FONT_SIZE;

lab = ylabel('Greiferl{\"a}nge [m]');
lab.Interpreter = 'latex';
lab.FontSize = LABEL_FONT_SIZE;

saveas(gcf,'P_regler_autom_Y.eps','epsc')

