files = {
    % path, file name (without .mat), start_time, end_time
    'Messungen_02_12_2020/', 'mess4_1', 2.5, 15;
    'Messungen_02_12_2020/', 'mess3_1', 1.8, 15;
};

for i = 1:size(files, 1)
    file_path = files{i, 1};
    file_name = files{i, 2};
    s = load(strcat(file_path, file_name, '.mat'));
    input_sig = [s.(file_name).X.Data; s.(file_name).Y.Data];
    input_sig = slice_time_series(input_sig, files{i, 3}, files{i, 4});
    input_sig(2,:) = input_sig(2,:) - input_sig(2,1);
    t = input_sig(1,:);
    y = input_sig(2,:);
    
    Xpos = [ones(size(t')), t'];
    Bpos = Xpos\y';
    line_x = [t(1), t(size(t, 2))];
    line_y = line_x .* Bpos(2) + Bpos(1);
    
    subplot(size(files, 1),1,i);
    plot(t, y, line_x, line_y)
    text(0, 0.5*y(size(y, 2)), strcat('Steigung: ', num2str(Bpos(2) * 1000), 'mV/s'))
end
