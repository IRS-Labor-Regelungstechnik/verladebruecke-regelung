function plot_messungen(input_signal_file, rotation_file, start_zeit, end_zeit)
% argument file names without file ending!
s = load(strcat(input_signal_file, '.mat'));
input_sig = [s.(input_signal_file).X.Data; s.(input_signal_file).Y.Data];
input_sig = slice_time_series(input_sig, start_zeit, end_zeit);
subplot(2,1,1);
plot(input_sig(1,:), input_sig(2,:))
%set_ylim(input_sig(2,:))

%s = load("mess1_Weg_Rotor_Umdrehungen.mat");
%weg_zeit = s.mess1_Weg_Rotor_Umdrehungen.X.Data;
%weg = s.mess1_Weg_Rotor_Umdrehungen.Y.Data; 

s = load(strcat(rotation_file, '.mat'));
winkel = [s.(rotation_file).X.Data; eliminate_rollover(s.(rotation_file).Y.Data)];
winkel = slice_time_series(winkel, start_zeit, end_zeit);

ableitung = gradient(winkel);
dot_winkel = ableitung(2,:) ./ ableitung(1,:);

subplot(2,1,2);
plot(winkel(1,:), dot_winkel(1,:))
%set_ylim(dot_winkel(1,:))
end