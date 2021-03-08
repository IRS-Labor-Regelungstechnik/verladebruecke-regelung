MAT_DIR = 'p-rate-lim-resp';

if isempty(regexp(pwd, strcat(MAT_DIR,'$'), 'ONCE'))
   error(strcat('Your current working directory must be: ', MAT_DIR));
end
results = dir('*.mat');

LEG_FONT_SIZE = 14;
LABEL_FONT_SIZE = 14;

for file = {results.name}
    data = load(file{1});
    data = data.ans;
    figure(1);
    if ~isempty(regexp(file{1}, 'STEP', 'ONCE'))
        % Data(:,1) is step response
        % Data(:,2) is step
        plot(data.Time, data.Data(:,2), data.Time, data.Data(:,1));
        leg = legend('Einheitssprung','Sprungantwort');     
        leg.Location = 'southeast';
        xlab = xlabel('t[s]');
        % ylab = ylabel('$$y_1, \dot{y}_1$$ [V]');
    elseif ~isempty(regexp(file{1}, 'DIFF', 'ONCE'))
        plot(data.Time, data.Data(:,2), data.Time, data.Data(:,1));
        leg = legend('Stellgroesse vor Rate Limiter', 'Stellgroesse nach Rate Limiter');     
        leg.Location = 'northeast';

        xlab = xlabel('t[s]');
        % ylab = ylabel('$$y_1, \dot{y}_1$$ [V]');
    end
    leg.Interpreter = 'latex';
    leg.FontSize = LEG_FONT_SIZE;
    xlab.Interpreter = 'latex';
    xlab.FontSize = LABEL_FONT_SIZE;
    % ylab.Interpreter = 'latex';
    
    % matlab2tikz(strrep(file{1}, '.mat', '.tex'),'floatFormat','%.3g', 'showInfo', false)
    saveas(gcf,strrep(file{1}, '.mat', '.eps'),'epsc')
end
