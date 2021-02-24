G_w = G_1/(1+G_1);
[mag_G,phase_G,wout_G] = bode(G_w);
mag_G = squeeze(mag_G);
phase_G = squeeze(phase_G);

[weg_butter.num, weg_butter.denom] = butter(2, 10.0, 's');
weg_butter.tf = tf(weg_butter.num, weg_butter.denom);
[mag_weg,phase_weg,wout_weg] = bode(weg_butter.tf);
mag_weg = squeeze(mag_weg);
phase_weg = squeeze(phase_weg);

figure(1)
semilogx(wout_G, 20*log10(mag_G), wout_weg, 20*log10(mag_weg))

leg = legend('$$20\log_{10}|G_w( j\omega )|$$', '$$20\log_{10}|F_{BW,weg}( j\omega )|$$');
leg.Location = 'northwest';
leg.Interpreter = 'latex';
xlab = xlabel('$$\omega$$ [1/s]');
xlab.Interpreter = 'latex';
ylab = ylabel('$$20\log_{10}|G_w( j\omega )|,~20\log_{10}|F_{BW,weg}( j\omega )|$$');
ylab.Interpreter = 'latex';

saveas(gcf,'C:\Users\Fritz\Nextcloud\KIT\LR\diagrams\bode_mag_Gw_Fweg.eps','epsc')

figure(2)
semilogx(wout_G, phase_G, wout_weg, phase_weg)

leg = legend('$$\angle G_w( j\omega )$$', '$$\angle F_{BW,weg}( j\omega )$$');
leg.Interpreter = 'latex';
xlab = xlabel('$$\omega$$ [1/s]');
xlab.Interpreter = 'latex';
ylab = ylabel('$$\angle G_w( j\omega ),~\angle F_{BW,weg}( j\omega )$$');
ylab.Interpreter = 'latex';

saveas(gcf,'C:\Users\Fritz\Nextcloud\KIT\LR\diagrams\bode_phase_Gw_Fweg.eps','epsc')

%figure(2)
%[num,denom] = butter(order, 2*pi*0.5, 's');
%[mag_B,phase_B,wout_B] = bode(tf(num, denom));