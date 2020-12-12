clear all;

start_zeit = 13;
end_zeit = 1000;

measurement_nr = '7';
nr_files = 4;

eliminate_rollover_for = 4;

for i = 1:nr_files
    file_name = strcat('mess',measurement_nr, '_', num2str(i));
    s = load(strcat(file_name, '.mat'));
    input_sig = [s.(file_name).X.Data; s.(file_name).Y.Data];
    if any(eliminate_rollover_for == i)
        input_sig(2,:) = eliminate_rollover(input_sig(2,:));
    end
    input_sig = slice_time_series(input_sig, start_zeit, end_zeit);
    subplot(nr_files,1,i);
    plot(input_sig(1,:), input_sig(2,:))
end


