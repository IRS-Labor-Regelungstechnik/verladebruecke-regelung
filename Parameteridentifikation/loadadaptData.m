function [eingangs_sig, ausgangs_sig] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, sample_time, ue, R)
% lade Daten, schneide Bereich aus und passe Vektor an Identification
% Toolbox an

% Eingangssignal
file_name = strcat('mess',measurement_nr(k), '_3');
s = load(strcat(file_name, '.mat'));
input_sig = [s.(file_name).X.Data; s.(file_name).Y.Data];
temp_sig = slice_time_series(input_sig, start_zeit(k), end_zeit(k)); % schneide Bereich aus
eingangs_sig = temp_sig(2,:)';

% 1V entspricht 450min^-1 = 7.5s^-1
% 10V entsprechen 4500min^-1 = 75s^-1
eingangs_sig = eingangs_sig .* 10;
eingangs_sig = eingangs_sig .* 7.5; % Umrechnung in s^-1
eingangs_sig(end) = []; % entferne letzten Eintrag da durch diff der ausgangsdaten Vektor um einen Eintrag reduziert wird


% Ausgangssignal
file_name = strcat('mess',measurement_nr(k), '_1');
s = load(strcat(file_name, '.mat'));
input_sig = [s.(file_name).X.Data; s.(file_name).Y.Data];
temp_sig = slice_time_series(input_sig, start_zeit(k), end_zeit(k)); % schneide Bereich aus
ausgangs_sig = temp_sig(2,:)';

% 0V entsprechen 0m
% 1V entspricht 2.54m
ausgangs_sig = ausgangs_sig .* 2.54; % Umrechnung in Strecke
ausgangs_sig = diff(ausgangs_sig)/sample_time;

ausgangs_sig = ausgangs_sig .* (ue/(2*pi*R)); % Umrechnung in Drehzahl

end