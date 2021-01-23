Q_s = [B_1, A_1 * B_1, A_1^2 * B_1, A_1^3 * B_1];
iQ_s = inv(Q_s);

t_1 = iQ_s(size(iQ_s,1),:);

iT = [t_1; t_1 * A_1; t_1 * A_1^2; t_1 * A_1^3];
T = inv(iT);

A_rnf = iT * A_1 / iT;
B_rnf = iT * B_1;
C_rnf = C_1 / iT;