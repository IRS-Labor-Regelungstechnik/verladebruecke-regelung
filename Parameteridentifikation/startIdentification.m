%
% Identifikation der PT1-Parameter
%

%%

clear all

%% Parameter
R = 0.046;
ue = 6;

K_K = 1;
T_K = 0.1;

strecke_ges = 2.54; % Strecke zwischen linkem und rechtem Endschalter

%% read Data
sample_time = 1e-3; % sekunden

start_zeit = [13 13 13 13];
end_zeit = [21 21 20 22];

% Messungen für Identifikation (Absolutwertgeber geht hier nicht in Begrenzung)
measurement_nr = ['2','3','4','5'];

%% 1. Messung
k = 1;
[eingangs_sig_1, ausgangs_sig_1] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, strecke_ges);
% Daten für Greybox Identifikation
avg = sum(ausgangs_sig_1(1:1000))/1000; % bilde Mittel der ersten 1000 Werte
ausgangs_sig_1 = ausgangs_sig_1(1:end) - avg; % Setze Anfangswert des Ausgangssignals auf Null
data1_grey = iddata(ausgangs_sig_1,eingangs_sig_1,sample_time);

% Daten für PT1 Identifikation
eingangs_sig_1(end) = []; % entferne letzten Eintrag da durch diff der ausgangsdaten Vektor um einen Eintrag reduziert wird
ausgangs_sig_1 = diff(ausgangs_sig_1)/sample_time;
ausgangs_sig_1 = ausgangs_sig_1 .* (ue/(2*pi*R)); % Umrechnung in Drehzahl
data1_pt1 = iddata(ausgangs_sig_1,eingangs_sig_1,sample_time);

%% 2. Messung
k = 2;
[eingangs_sig_2, ausgangs_sig_2] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, strecke_ges);
% Daten für Greybox Identifikation
avg = sum(ausgangs_sig_2(1:1000))/1000; % bilde Mittel der ersten 1000 Werte
ausgangs_sig_2 = ausgangs_sig_2(1:end) - avg; % Setze Anfangswert des Ausgangssignals auf Null
data2_grey = iddata(ausgangs_sig_2,eingangs_sig_2,sample_time);

% Daten für PT1 Identifikation
eingangs_sig_2(end) = []; % entferne letzten Eintrag da durch diff der ausgangsdaten Vektor um einen Eintrag reduziert wird
ausgangs_sig_2 = diff(ausgangs_sig_2)/sample_time;
ausgangs_sig_2 = ausgangs_sig_2 .* (ue/(2*pi*R)); % Umrechnung in Drehzahl
data2_pt1 = iddata(ausgangs_sig_2,eingangs_sig_2,sample_time);

%% 3. Messung
k = 3;
[eingangs_sig_3, ausgangs_sig_3] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, strecke_ges);
% Daten für Greybox Identifikation
avg = sum(ausgangs_sig_3(1:1000))/1000; % bilde Mittel der ersten 1000 Werte
ausgangs_sig_3 = ausgangs_sig_3(1:end) - avg; % Setze Anfangswert des Ausgangssignals auf Null
data3_grey = iddata(ausgangs_sig_3,eingangs_sig_3,sample_time);

% Daten für PT1 Identifikation
eingangs_sig_3(end) = []; % entferne letzten Eintrag da durch diff der ausgangsdaten Vektor um einen Eintrag reduziert wird
ausgangs_sig_3 = diff(ausgangs_sig_3)/sample_time;
ausgangs_sig_3 = ausgangs_sig_3 .* (ue/(2*pi*R)); % Umrechnung in Drehzahl
data3_pt1 = iddata(ausgangs_sig_3,eingangs_sig_3,sample_time);

%% 4. Messung
k = 4;
[eingangs_sig_4, ausgangs_sig_4] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, strecke_ges);
% Daten für Greybox Identifikation
avg = sum(ausgangs_sig_4(1:1000))/1000; % bilde Mittel der ersten 1000 Werte
ausgangs_sig_4 = ausgangs_sig_4(1:end) - avg; % Setze Anfangswert des Ausgangssignals auf Null
data4_grey = iddata(ausgangs_sig_4,eingangs_sig_4,sample_time);

% Daten für PT1 Identifikation
eingangs_sig_4(end) = []; % entferne letzten Eintrag da durch diff der ausgangsdaten Vektor um einen Eintrag reduziert wird
ausgangs_sig_4 = diff(ausgangs_sig_4)/sample_time;
ausgangs_sig_4 = ausgangs_sig_4 .* (ue/(2*pi*R)); % Umrechnung in Drehzahl
data4_pt1 = iddata(ausgangs_sig_4,eingangs_sig_4,sample_time);

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

%systemIdentification

%% Identifikation des gesamten Teilsystems
% Daten hierzu: datax_grey
data_grey = merge(data1_grey,data2_grey,data3_grey,data4_grey);

% stelle Greyboxmodell auf
aux(1) = R;
aux(2) = ue;
aux(3) = K_K;

par_guess = 0.1;

ts = 0; % kontinuierliches Modell
model_greybox = idgrey('calcSysMatrixId', par_guess, 'c', aux, 0);

% Identifikation
model = greyest(data_grey, model_greybox, greyestOptions('Display','on'));




