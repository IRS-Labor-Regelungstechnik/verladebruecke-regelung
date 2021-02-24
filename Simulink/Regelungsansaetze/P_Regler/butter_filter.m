%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% berechne Butterworthfilter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameter

% minimale Seill?nge
L_min = 0.05; % m
T = 2*pi*sqrt(L_min / 9.81); % sek

cutofffreq = (1/T) * 10; % in Hz
% f?r geringe Phasenverschiebung wird als cutoff die 10 fache Frequenz der
% h?chstfrequenten auftretenden Schwingung verwendet

%% berechne Tierpassfilter

[angle_butter.num, angle_butter.denom] = butter(2, 2*pi*cutofffreq, 's');

[weg_butter.num, weg_butter.denom] = butter(2, 2*pi*10.0, 's');

order = 2;
[weg_butter.tf_0p1_num, weg_butter.tf_0p1_denom] = butter(order, 2*pi*0.1, 's');
[weg_butter.tf_0p5_num, weg_butter.tf_0p5_denom] = butter(order, 2*pi*0.5, 's');
[weg_butter.tf_1p0_num, weg_butter.tf_1p0_denom] = butter(order, 2*pi*10.0, 's');
%[weg_butter.A, weg_butter.B, weg_butter.C, weg_butter.D] = butter(order, 2*pi*0.1, 's');
