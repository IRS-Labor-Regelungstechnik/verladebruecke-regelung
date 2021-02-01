%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% berechne Butterworthfilter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameter

order = 1;
cutofffreq = 100; % in Hz

%% berechne Tierpassfilter

[A_butter, B_butter, C_butter, D_butter] = butter(order, 2*pi*cutofffreq, 's');





