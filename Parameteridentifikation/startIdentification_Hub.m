%
% Identifikation der PT1-Parameter des Hubsystems
%

%%

clear all

%% Parameter
R = 0.021975; % durchschnittlicher Radius der Seiltrommel
ue = 3;

K_K = 1;
T_K = 0.1; % initial value, wird später geschätzt

%% read Data
sample_time = 1e-3; % sekunden

% gesamtes Signal
start_zeit = [13 13 15 15]; % in sekunden
end_zeit = [22 22 23 24];
% repräsentative Messungen
measurement_nr = [11,12,13,14];


% Signalteile, die für Identifikation des PT1-Gliedes (ohne Beschränkung
% des Umrichters) verwendet werden können
% start_zeit = [13 13]; % in sekunden
% end_zeit = [17 20];
% measurement_nr = [13,14];

%% 1. Messung
k = 1;
[eingangs_sig_1, ~, resolver_sig_1] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, 1, R, ue);
% Resolverdaten
avg = sum(resolver_sig_1(1:10))/10; % bilde Mittel der ersten 10 Werte
resolver_sig_1 = resolver_sig_1(1:end) - avg; % Setze Anfangswert des Ausgangssignals auf Null

% Daten für PT1 Identifikation
eingangs_sig_1(end) = []; % entferne letzten Eintrag da durch diff der ausgangsdaten Vektor um einen Eintrag reduziert wird
resolver_sig_1 = diff(resolver_sig_1)/sample_time;
resolver_sig_1 = resolver_sig_1 .* (ue/(2*pi*R)); % Umrechnung in Drehzahl (berechnung aus loadadaptData rückgängig machen)
data1_pt1 = iddata(resolver_sig_1,eingangs_sig_1,sample_time);

%% 2. Messung
k = 2;
[eingangs_sig_2, ~, resolver_sig_2] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, 1, R, ue);
% Resolverdaten
avg = sum(resolver_sig_2(1:10))/10; % bilde Mittel der ersten 10 Werte
resolver_sig_2 = resolver_sig_2(1:end) - avg; % Setze Anfangswert des Ausgangssignals auf Null
data2_resolver = iddata(resolver_sig_2,eingangs_sig_2,sample_time);

% Daten für PT1 Identifikation
eingangs_sig_2(end) = []; % entferne letzten Eintrag da durch diff der ausgangsdaten Vektor um einen Eintrag reduziert wird
resolver_sig_2 = diff(resolver_sig_2)/sample_time;
resolver_sig_2 = resolver_sig_2 .* (ue/(2*pi*R)); % Umrechnung in Drehzahl
data2_pt1 = iddata(resolver_sig_2,eingangs_sig_2,sample_time);

%% 3. Messung
k = 3;
[eingangs_sig_3, ~, resolver_sig_3] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, 1, R, ue);
% Resolverdaten
avg = sum(resolver_sig_3(1:10))/10; % bilde Mittel der ersten 10 Werte
resolver_sig_3 = resolver_sig_3(1:end) - avg; % Setze Anfangswert des Ausgangssignals auf Null
data3_resolver = iddata(resolver_sig_3,eingangs_sig_3,sample_time);

% Daten für PT1 Identifikation
eingangs_sig_3(end) = []; % entferne letzten Eintrag da durch diff der ausgangsdaten Vektor um einen Eintrag reduziert wird
resolver_sig_3 = diff(resolver_sig_3)/sample_time;
resolver_sig_3 = resolver_sig_3 .* (ue/(2*pi*R)); % Umrechnung in Drehzahl
data3_pt1 = iddata(resolver_sig_3,eingangs_sig_3,sample_time);

%% 4. Messung
k = 4;
[eingangs_sig_4, ~, resolver_sig_4] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, 1, R, ue);
% Resolverdaten
avg = sum(resolver_sig_4(1:10))/10; % bilde Mittel der ersten 10 Werte
resolver_sig_4 = resolver_sig_4(1:end) - avg; % Setze Anfangswert des Ausgangssignals auf Null
data4_resolver = iddata(resolver_sig_4,eingangs_sig_4,sample_time);

% Daten für PT1 Identifikation
eingangs_sig_4(end) = []; % entferne letzten Eintrag da durch diff der ausgangsdaten Vektor um einen Eintrag reduziert wird
resolver_sig_4 = diff(resolver_sig_4)/sample_time;
resolver_sig_4 = resolver_sig_4 .* (ue/(2*pi*R)); % Umrechnung in Drehzahl
data4_pt1 = iddata(resolver_sig_4,eingangs_sig_4,sample_time);

%% Filterung der Messdaten (nur für Daten zur PT1 Identifikation)
% Filterung mit Tiefpass: Grenzfrequenz: 36 Hz
% Filter: Butterworthfilter 5. Ordnung

data1_pt1_f = idfilt(data1_pt1,5,0.072); % Bandpass 36Hz
data2_pt1_f = idfilt(data2_pt1,5,0.072);
data3_pt1_f = idfilt(data3_pt1,5,0.072);
data4_pt1_f = idfilt(data4_pt1,5,0.072);

% ersetze gefilterte Eingangsdaten durch ungefilterte Eingangsdaten
data1_pt1_f.u = data1_pt1.u;
data2_pt1_f.u = data2_pt1.u;
data3_pt1_f.u = data3_pt1.u;
data4_pt1_f.u = data4_pt1.u;

%% Identifikation des PT1-Gliedes
% Daten hierzu: datax_pt1_f
data_pt1_f = merge(data3_pt1_f,data4_pt1_f);

%systemIdentification

% Identifikation auf Grundlage der abgeleiteten Resolverdaten

