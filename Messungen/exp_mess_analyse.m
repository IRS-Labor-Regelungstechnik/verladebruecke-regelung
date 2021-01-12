%
% erzeuge Plot der 4 Messungen
%

%%

% _1: Messung des Signals des Absolutwertgebers
% _2: Messung des Greiferwinkels
% _3: Messung des Eingangssignals
% _4: Messung des Resolversignals

%%
clear all;

%% Parameter
start_zeit = 0;
end_zeit = 1000;

measurement_nr = '2';
nr_files = 4;

eliminate_rollover_for = 4; % Messung des Resolvers -> eliminiere rollover

%% Plotte Messungen
for i = 1:nr_files
    % lade Daten der aktuellen Messung
    file_name = strcat('mess',measurement_nr, '_', num2str(i));
    s = load(strcat(file_name, '.mat'));
    input_sig = [s.(file_name).X.Data; s.(file_name).Y.Data];
    
    % eliminiere rollover
    if any(eliminate_rollover_for == i)
        input_sig(2,:) = eliminate_rollover(input_sig(2,:));
    end
    
    % plot
    input_sig = slice_time_series(input_sig, start_zeit, end_zeit); % schneide Bereich aus
    subplot(nr_files,1,i);
    plot(input_sig(1,:), input_sig(2,:))
end


