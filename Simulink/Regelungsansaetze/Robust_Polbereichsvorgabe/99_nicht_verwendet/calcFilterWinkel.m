%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% berechne Butterworthfilter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameter

% minimale Seill�nge
L_min = 0.05; % m
T = 2*pi*sqrt(L_min / 9.81); % sek

order = 1;
cutofffreq = (1/T) * 10; % in Hz
% f�r geringe Phasenverschiebung wird als cutoff die 10 fache Frequenz der
% h�chstfrequenten auftretenden Schwingung verwendet

%% berechne Tierpassfilter

[A_b_angle, B_b_angle, C_b_angle, D_b_angle] = butter(order, 2*pi*cutofffreq, 's');

