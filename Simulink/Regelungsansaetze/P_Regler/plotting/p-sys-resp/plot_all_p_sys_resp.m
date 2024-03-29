MAT_DIR = 'p-sys-resp';

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
        legend('Sprungantwort', 'Einheitssprung')
        saveas(gcf,strrep(file{1}, '.mat', '.eps'),'epsc')
    elseif ~isempty(regexp(file{1}, 'ANGLE', 'ONCE'))
        data = load(file{1});
        data = data.ans;
        figure(1);
        % Data(:,1) is angle resp
        plot(data.Time, data.Data(:,1));
        legend('Greiferwinkel')
        saveas(gcf,strrep(file{1}, '.mat', '.eps'),'epsc')
    end
end
