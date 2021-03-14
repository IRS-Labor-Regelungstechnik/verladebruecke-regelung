MAT_DIR = 'P_Regler';

if isempty(regexp(pwd, strcat(MAT_DIR,'$'), 'ONCE'))
   error(strcat('Your current working directory must be: ', MAT_DIR));
end

G1_w = G_1/(1+G_1);
[mag_G1,phase_G1,wout_G1] = bode(G1_w);
mag_G1 = squeeze(mag_G1);
phase_G1 = squeeze(phase_G1);

[weg_butter.num, weg_butter.denom] = butter(2, 10.0, 's');
weg_butter.tf = tf(weg_butter.num, weg_butter.denom);
[mag_weg,phase_weg,wout_weg] = bode(weg_butter.tf);
mag_weg = squeeze(mag_weg);
phase_weg = squeeze(phase_weg);

LEG_FONT_SIZE = 16;
LABEL_FONT_SIZE = 16;

figure(1)
semilogx(wout_G1, 20*log10(mag_G1), wout_weg, 20*log10(mag_weg))

leg = legend('$$20\log_{10}|G_w( j\omega )|$$', '$$20\log_{10}|F_{BW,weg}( j\omega )|$$');
leg.Location = 'southwest';
leg.Interpreter = 'latex';
leg.FontSize = LEG_FONT_SIZE;
xlab = xlabel('$$\omega$$ [1/s]');
xlab.Interpreter = 'latex';
xlab.FontSize = LABEL_FONT_SIZE;
ylab = ylabel('$$20\log_{10}|\{G_w,F_{BW,weg}\}( j\omega )|$$');
ylab.Interpreter = 'latex';
ylab.FontSize = LABEL_FONT_SIZE;

filename = 'bode_mag_Gw_Fweg.eps';
saveas(gcf,filename,'epsc')

figure(2)
semilogx(wout_G1, phase_G1, wout_weg, phase_weg)

leg = legend('$$\angle G_w( j\omega )$$', '$$\angle F_{BW,weg}( j\omega )$$');
leg.Location = 'southwest';
leg.Interpreter = 'latex';
leg.FontSize = LEG_FONT_SIZE;
xlab = xlabel('$$\omega$$ [1/s]');
xlab.Interpreter = 'latex';
xlab.FontSize = LABEL_FONT_SIZE;
ylab = ylabel('$$\angle \{G_w,F_{BW,weg}\}( j\omega )$$');
ylab.Interpreter = 'latex';
ylab.FontSize = LABEL_FONT_SIZE;

filename = 'bode_phase_Gw_Fweg.eps';
saveas(gcf,filename,'epsc')

%figure(2)
%[num,denom] = butter(order, 2*pi*0.5, 's');
%[mag_B,phase_B,wout_B] = bode(tf(num, denom));