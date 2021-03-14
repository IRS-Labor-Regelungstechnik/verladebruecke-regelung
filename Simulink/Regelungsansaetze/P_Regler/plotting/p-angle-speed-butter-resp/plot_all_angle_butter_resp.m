MAT_DIR = 'p-angle-speed-butter-resp';

if isempty(regexp(pwd, strcat(MAT_DIR,'$'), 'ONCE'))
   error(strcat('Your current working directory must be: ', MAT_DIR));
end
results = dir('*.mat');

LEG_FONT_SIZE = 12;
LABEL_FONT_SIZE = 14;

for file = {results.name}
    data = load(file{1});
    data = data.ans;
    figure(1);

    plot(data.Time, data.Data(:,2), data.Time, data.Data(:,1));
    leg = legend('Winkelausschlag $$y_3$$', 'Winkelgeschwindigkeit $$\dot{y}_3$$');
    xlab = xlabel('t[s]');
    ylab = ylabel('$$y_3, \dot{y}_3$$ [deg]');

    leg.Interpreter = 'latex';
    leg.FontSize = LEG_FONT_SIZE;
    xlab.Interpreter = 'latex';
    xlab.FontSize = LABEL_FONT_SIZE;
    ylab.Interpreter = 'latex';
    ylab.FontSize = LABEL_FONT_SIZE;
    
    saveas(gcf,strrep(file{1}, '.mat', '.eps'),'epsc')
end
