MAT_DIR = 'p-angle-speed-butter-resp';

if isempty(regexp(pwd, strcat(MAT_DIR,'$'), 'ONCE'))
   error(strcat('Your current working directory must be: ', MAT_DIR));
end
results = dir('*.mat');

for file = {results.name}
    data = load(file{1});
    data = data.ans;
    figure(1);

    plot(data.Time, data.Data(:,2), data.Time, data.Data(:,1));
    leg = legend('Winkelausschlag $$y_3$$', 'Winkelgeschwindigkeit $$\dot{y}_3$$');
    leg.Interpreter = 'latex';

    xlab = xlabel('t[s]');
    xlab.Interpreter = 'latex';
    ylab = ylabel('$$y_3, \dot{y}_3$$ [deg]');
    ylab.Interpreter = 'latex';

    
    saveas(gcf,strrep(file{1}, '.mat', '.eps'),'epsc')
end
