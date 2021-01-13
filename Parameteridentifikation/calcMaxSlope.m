%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Berechne die maximale Steigung in der 
% Drehzahl, die der Umrichter zulässt
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
clear all

%% Parameter
R = 0.046;
ue = 6;

%% read Data
sample_time = 1e-3; % sekunden

% Schätzung der maximalen Steigung der Drehzahl
start_zeit = [18.5 15.3 17.45 20.2 16.3]; % in sekunden
end_zeit = [19.2 15.8 17.8 20.5 17];
measurement_nr = [2 3 4 5 10];

x1=(18.5:0.001:19.2);
x1(end)=[];
x2=(15.3:0.001:15.8);
x2(end)=[];
x3=(17.45:0.001:17.8);
x3(end)=[];
x4=(20.2:0.001:20.5);
x4(end)=[];
x5=(16.3:0.001:17);
x5(end)=[];


%% 1. Messung
k = 1;
[eingangs_sig_1, ~, resolver_sig_1] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, 0, R, ue);

% Resolverdaten
avg = sum(resolver_sig_1(1:10))/10; % bilde Mittel der ersten 10 Werte
resolver_sig_1 = resolver_sig_1(1:end) - avg; % Setze Anfangswert des Ausgangssignals auf Null

resolver_sig_1 = diff(resolver_sig_1)/sample_time;
resolver_sig_1 = resolver_sig_1 .* (ue/(2*pi*R)); % Umrechnung in Drehzahl

%% 2. Messung
k = 2;
[eingangs_sig_2, ~, resolver_sig_2] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, 0, R, ue);

% Resolverdaten
avg = sum(resolver_sig_2(1:10))/10; % bilde Mittel der ersten 10 Werte
resolver_sig_2 = resolver_sig_2(1:end) - avg; % Setze Anfangswert des Ausgangssignals auf Null

resolver_sig_2 = diff(resolver_sig_2)/sample_time;
resolver_sig_2 = resolver_sig_2 .* (ue/(2*pi*R)); % Umrechnung in Drehzahl

%% 3. Messung
k = 3;
[eingangs_sig_3, ~, resolver_sig_3] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, 0, R, ue);

% Resolverdaten
avg = sum(resolver_sig_3(1:10))/10; % bilde Mittel der ersten 10 Werte
resolver_sig_3 = resolver_sig_3(1:end) - avg; % Setze Anfangswert des Ausgangssignals auf Null

resolver_sig_3 = diff(resolver_sig_3)/sample_time;
resolver_sig_3 = resolver_sig_3 .* (ue/(2*pi*R)); % Umrechnung in Drehzahl

%% 4. Messung
k = 4;
[eingangs_sig_4, ~, resolver_sig_4] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, 0, R, ue);

% Resolverdaten
avg = sum(resolver_sig_4(1:10))/10; % bilde Mittel der ersten 10 Werte
resolver_sig_4 = resolver_sig_4(1:end) - avg; % Setze Anfangswert des Ausgangssignals auf Null

resolver_sig_4 = diff(resolver_sig_4)/sample_time;
resolver_sig_4 = resolver_sig_4 .* (ue/(2*pi*R)); % Umrechnung in Drehzahl

%% 5. Messung % nicht in Identifikationsdatensatz enthalten
k = 5;
[eingangs_sig_5, ~, resolver_sig_5] = loadadaptData(k, measurement_nr, start_zeit, end_zeit, 0, R, ue);

% Resolverdaten
avg = sum(resolver_sig_5(1:10))/10; % bilde Mittel der ersten 10 Werte
resolver_sig_5 = resolver_sig_5(1:end) - avg; % Setze Anfangswert des Ausgangssignals auf Null

resolver_sig_5 = diff(resolver_sig_5)/sample_time;
resolver_sig_5 = resolver_sig_5 .* (ue/(2*pi*R)); % Umrechnung in Drehzahl

%% starte curve fitting toolbox

cftool

% Füge die 5 resolversignale mit den zugehörigen x-Werten ein und fitte ein
% Polynaom vom Grad 1 an die Messungen

