
r = 0.1;

mdl = 'laufkatze_motor';
% open_system(mdl);
in = Simulink.SimulationInput(mdl);
in.setBlockParameter('laufkatze_motor/MahBoy', 'Value', 5)


out = sim(in)


% simOut = sim('laufkatze_motor')