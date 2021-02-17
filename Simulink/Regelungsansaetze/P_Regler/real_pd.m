K_R = 0.01;
T_R = 20;
T_N = 1;
pd1 = tf(K_R*[T_R, 1], [T_N, 1]);
figure(1)
bode(pd1);

K_R = 0.01;
T_R = 2;
T_N = 1;
pd2 = tf(K_R*[T_R, 1], [T_N, 1]);
figure(2)
bode(pd2);