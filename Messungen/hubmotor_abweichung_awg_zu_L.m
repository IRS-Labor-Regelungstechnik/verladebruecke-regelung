L_max = 160.5; %cm
L_min = 23; %cm
r_1 = 2.5; %cm
r_0 = 1.895;  %cm

r = @(L) ((r_0 - r_1) / (L_max - L_min)) * (L - L_min) + r_1;

dn_dL = @(L) (1 ./ (2*pi*r(L)));

x = (L_min+0.1):0.1:L_max;
% plot(x, dn_dL(x));

n = @(L) integral(dn_dL, L_min, L);

n_ges = n(L_max);

% (L_max - L_min) / (2*pi*r_0)  % max umdrehungen = 11.8291
% (L_max - L_min) / (2*pi*r_1)  % min umdrehungen = 9.3123

k_umd = 10 / n_ges;  % V pro Umdrehung
k_weg = 10 / (L_max - L_min);

U_angen = k_weg .* (x - L_min);

U_real = zeros(size(x));
for i = 1:size(x, 2)
    U_real(i) = k_umd * n(x(i));
end

max_diff = max(U_angen - U_real)/10;

plot(x, U_real, x, U_angen)