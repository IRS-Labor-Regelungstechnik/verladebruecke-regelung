MAT_DIR = 'p-rate-lim-resp';

if isempty(regexp(pwd, strcat(MAT_DIR,'$'), 'ONCE'))
   error(strcat('Your current working directory must be: ', MAT_DIR));
end
results = dir('*.mat');

for file = {results.name}
    if ~isempty(regexp(file{1}, 'STEP', 'ONCE'))
        data = load(file{1});
        data = data.ans;
        figure(1);
        % Data(:,1) is step response
        % Data(:,2) is step
        plot(data.Time, data.Data(:,2), data.Time, data.Data(:,1));
        leg = legend('Einheitssprung','Sprungantwort');
        
        leg.Location = 'southeast';
        % leg.Interpreter = 'latex';
        leg.FontSize = 12;

        xlab = xlabel('t[s]');
        xlab.Interpreter = 'latex';
        % ylab = ylabel('$$y_1, \dot{y}_1$$ [V]');
        % ylab.Interpreter = 'latex';
        
        
    elseif ~isempty(regexp(file{1}, 'DIFF', 'ONCE'))
        data = load(file{1});
        data = data.ans;
        figure(1);

        plot(data.Time, data.Data(:,2), data.Time, data.Data(:,1));
        leg = legend('Stellgroesse vor Rate Limiter', 'Stellgroesse nach Rate Limiter');
        
        leg.Location = 'northeast';
        % leg.Interpreter = 'latex';
        leg.FontSize = 12;

        xlab = xlabel('t[s]');
        xlab.Interpreter = 'latex';
        % ylab = ylabel('$$y_1, \dot{y}_1$$ [V]');
        % ylab.Interpreter = 'latex';
        
    end
    saveas(gcf,strrep(file{1}, '.mat', '.eps'),'epsc')
end
