function [eingangs_sig, ausgangs_sig, resolver_sig] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, strecke_ges, R, ue)
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


% Ausgangssignal
file_name = strcat('mess',measurement_nr(k), '_1');
s = load(strcat(file_name, '.mat'));
input_sig = [s.(file_name).X.Data; s.(file_name).Y.Data];
temp_sig = slice_time_series(input_sig, start_zeit(k), end_zeit(k)); % schneide Bereich aus
ausgangs_sig = temp_sig(2,:)';

% 0V entsprechen 0m
% 1V entspricht 2.54m
ausgangs_sig = ausgangs_sig .* strecke_ges; % Umrechnung in Strecke


% Resolver
file_name = strcat('mess',measurement_nr(k), '_4');
s = load(strcat(file_name, '.mat'));
input_sig = [s.(file_name).X.Data; s.(file_name).Y.Data];
temp_sig = slice_time_series(input_sig, start_zeit(k), end_zeit(k)); % schneide Bereich aus
resolver_sig = temp_sig(2,:);

resolver_sig = eliminate_rollover(resolver_sig)'; % eliminiere rollover
resolver_sig = resolver_sig .* (1/360); % umrechung in umdrehungen
resolver_sig = resolver_sig .* (2*pi*R/ue); % umrechnung in strecke

end