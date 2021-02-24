% minimale Seill?nge
L_min = 0.05; % m
T = sqrt(L_min / 9.81); % sek

cutofffreq = (1/T) * 10; % in Hz
% f?r geringe Phasenverschiebung wird als cutoff die 10 fache Frequenz der
% h?chstfrequenten auftretenden Schwingung verwendet


[angle_butter.num, angle_butter.denom] = butter(2, cutofffreq, 's');
angle_butter.tf = tf(angle_butter.num, angle_butter.denom);

[mag_ang,phase_ang,wout_ang] = bode(angle_butter.tf);
mag_ang = squeeze(mag_ang);
phase_ang = squeeze(phase_ang);

figure(1)
semilogx(wout_ang, 20*log10(mag_ang))
xlab = xlabel('$$\omega$$ [1/s]');
set(xlab,'Interpreter','latex');
ylab = ylabel('$$20*\log_{10}|F_{BW,\vartheta}( j\omega )|$$');
set(ylab,'Interpreter','latex');
%saveas(gcf,'C:\Users\Fritz\Nextcloud\KIT\LR\diagrams\bode_mag_angle_butter.eps','epsc')

figure(2)
semilogx(wout_ang, phase_ang)
xlab = xlabel('$$\omega$$ [1/s]');
set(xlab,'Interpreter','latex');
ylab = ylabel('$$\angle F_{BW,\vartheta}( j\omega )$$');
set(ylab,'Interpreter','latex');
%saveas(gcf,'C:\Users\Fritz\Nextcloud\KIT\LR\diagrams\bode_phase_angle_butter.eps','epsc')