G_w = G_1/(1+G_1);
figure(1)
[mag_G,phase_G,wout_G] = bode(G_w);
mag_G = squeeze(mag_G);
phase_G = squeeze(phase_G);

w_1 = find(wout_G > 500, 1);
w_2 = find(wout_G > 1e2, 1);

coefficients = polyfit([wout_G(w_1), wout_G(w_2)], [mag_G(w_1), mag_G(w_2)], 1);
a = coefficients (1);
b = coefficients (2);

semilogx(wout_G, 20*log10(mag_G))

%figure(2)
[num,denom] = butter(order, 2*pi*0.5, 's');
[mag_B,phase_B,wout_B] = bode(tf(num, denom));