MAT_DIR = 'p-weg-speed-butter-resp';

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
    leg = legend('Laufkatzenposition $$y_1$$', 'Laufkatzengeschwindigkeit $$\dot{y}_1$$');
    leg.Location = 'east';
    leg.Interpreter = 'latex';
    leg.FontSize = LEG_FONT_SIZE;

    xlab = xlabel('t[s]');
    xlab.Interpreter = 'latex';
    xlab.FontSize = LABEL_FONT_SIZE;
    ylab = ylabel('$$y_1, \dot{y}_1$$ [V]');
    ylab.Interpreter = 'latex';
    ylab.FontSize = LABEL_FONT_SIZE;
    
    saveas(gcf,strrep(file{1}, '.mat', '.eps'),'epsc')
end
