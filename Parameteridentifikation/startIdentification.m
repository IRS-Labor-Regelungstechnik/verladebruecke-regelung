%
% Identifikation der PT1-Parameter
%

%%

clear all

%% Parameter
R = 0.046;
ue = 6;

strecke_ges = 2.54; % Strecke zwischen linkem und rechtem Endschalter

%% read Data
sample_time = 1e-3; % sekunden

start_zeit = [13 13 13 13];
end_zeit = [21 21 20 22];

% Messungen für Identifikation (Absolutwertgeber geht hier nicht in Begrenzung)
measurement_nr = ['2','3','4','5'];

%% 1. Messung
k = 1;
[eingangs_sig_1, ausgangs_sig_1] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, sample_time, ue, R);
data1 = iddata(ausgangs_sig_1,eingangs_sig_1,sample_time);

%% 1. Messung
k = 2;
[eingangs_sig_2, ausgangs_sig_2] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, sample_time, ue, R);
data2 = iddata(ausgangs_sig_2,eingangs_sig_2,sample_time);

%% 1. Messung
k = 3;
[eingangs_sig_3, ausgangs_sig_3] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, sample_time, ue, R);
data3 = iddata(ausgangs_sig_3,eingangs_sig_3,sample_time);

%% 1. Messung
k = 4;
[eingangs_sig_4, ausgangs_sig_4] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, sample_time, ue, R);
data4 = iddata(ausgangs_sig_4,eingangs_sig_4,sample_time);

%% Filterung der Messdaten
% Filterung mit Tiefpass: Grenzfrequenz: 36 Hz
% Filter: Butterworthfilter 5. Ordnung

data1_f = idfilt(data1,5,0.072); % Bandpass 36Hz
data2_f = idfilt(data2,5,0.072);
data3_f = idfilt(data3,5,0.072);
data4_f = idfilt(data4,5,0.072);

% ersetze gefilterte Eingangsdaten durch ungefilterte Eingangsdaten
data1_f.u = data1.u;
data2_f.u = data2.u;
data3_f.u = data3.u;
data4_f.u = data4.u;

%% Identifikation

systemIdentification






