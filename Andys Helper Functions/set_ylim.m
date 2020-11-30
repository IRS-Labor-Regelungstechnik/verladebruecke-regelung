function set_ylim(measurements)
    max_sig = max(measurements);
    min_sig = min(measurements);
    diff_sig = abs(max_sig - min_sig);
    lim_factor = 0.2;
    ylim([min_sig-lim_factor*diff_sig max_sig+lim_factor*diff_sig]);
end
