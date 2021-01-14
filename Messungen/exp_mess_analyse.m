%
% erzeuge Plot der 4 Messungen
%

%%

AWG_sig = 1; % _1: Messung des Signals des Absolutwertgebers
winkel_sig = 2; % _2: Messung des Greiferwinkels
input_sig = 3; % _3: Messung des Eingangssignals
resolver_sig = 4; % _4: Messung des Resolversignals

%% Parameter
start_zeit = 0; 
end_zeit = 1000;

measurement_nr = '3';

nr_files = 4;

meas_data = [];  % this can be loaded in simulink via From Workspace

%% Plotte Messungen
for i = 1:nr_files
    % lade Daten der aktuellen Messung
    file_name = strcat('mess',measurement_nr, '_', num2str(i));
    s = load(strcat(file_name, '.mat'));
    input_sig = [s.(file_name).X.Data; s.(file_name).Y.Data];
    
    % eliminiere rollover
    if i == resolver_sig
        input_sig(2,:) = eliminate_rollover(input_sig(2,:));
    end
    
    
    input_sig = slice_time_series(input_sig, start_zeit, end_zeit); % schneide Bereich aus
    
    if i == AWG_sig
        % Den Anfangswert des AWG Signals m?ssen wir auf 0 Stellen oder im Modell den
        % Anfangswert daf?r anpassen. Einfacher ist die erste Variante.
        input_sig(2,:) = input_sig(2,:) - input_sig(2,1);
    end
    
    if isempty(meas_data)
        meas_data = input_sig';
    else
        meas_data(:,size(meas_data,2)+1) = input_sig(2,:)';
    end
    
    % plot
    subplot(nr_files,1,i);
    plot(input_sig(1,:), input_sig(2,:))
end


