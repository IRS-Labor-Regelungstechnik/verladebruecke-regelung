clear all;

files = {
    % file name, start_time, end_time
    'mess4_2', 18, 100;
    'mess5_2', 20.9, 100;
    'mess6_2', 21.4, 100;
    'mess7_2', 20.4, 100;
};

pos_peak_line_gradients = zeros(1, size(files, 1));
neg_peak_line_gradients = zeros(1, size(files, 1));
damping = zeros(1, size(files, 1));

for i = 3%:size(files, 1)
    file_name = files{i, 1};
    s = load(strcat(file_name, '.mat'));
    input_sig = [s.(file_name).X.Data; s.(file_name).Y.Data];
    input_sig = slice_time_series(input_sig, files{i, 2}, files{i, 3});
    t = input_sig(1,:);
    y = input_sig(2,:);
    t = t - files{i, 2};
    y = y - 180;
    
    fit = @(b,t)  b(1) .* exp(- b(2) * t);
    
    [pos_peaks, pos_peak_loc] = findpeaks(y(y>0),t(y>0));
    fcn = @(b) sum((fit(b,pos_peak_loc) - pos_peaks).^2); 
    pos_exp_fit = fminsearch(fcn, [pos_peaks(1), 0.02]);
    pos_damp = pos_exp_fit(1) .* exp(- pos_exp_fit(2) * pos_peak_loc);
    
    [neg_peaks, neg_peak_loc] = findpeaks(-y(y<0),t(y<0));
    neg_peaks = -neg_peaks;
    fcn = @(b) sum((fit(b,neg_peak_loc) - neg_peaks).^2); 
    neg_exp_fit = fminsearch(fcn, [neg_peaks(1), 0.02]);
    neg_damp = neg_exp_fit(1) .* exp(- neg_exp_fit(2) * neg_peak_loc);
   
%     Xpos = [ones(size(pos_peak_loc')), pos_peak_loc'];
%     Bpos = Xpos\pos_peaks';
%     pos_peak_line_x = [t(1), t(size(t, 2))];
%     pos_peak_line_y = pos_peak_line_x .* Bpos(2) + Bpos(1);
%     pos_peak_line_gradients(i) = Bpos(2);
%     
%     Xneg = [ones(size(neg_peak_loc')), neg_peak_loc'];
%     Bneg = Xneg\neg_peaks';
%     neg_peak_line_x = [t(1), t(size(t, 2))];
%     neg_peak_line_y = neg_peak_line_x .* Bneg(2) + Bneg(1);
%     neg_peak_line_gradients(i) = Bneg(2);
    
%     time_diffs = pos_peak_loc(2:size(pos_peak_loc, 2)) - ...
%         pos_peak_loc(1:(size(pos_peak_loc, 2)-1));
%     k_init = 4; % Amplitude
%     d_init = 0; % Damping
%     T_init = sum(time_diffs) / size(time_diffs, 2);  %Period
%     t0_init = pos_peak_loc(1); %Zeitversatz

    
    % fit = @(b,x)  b(1).*(sin(2*pi*x./b(2) + 2*pi/b(3))) + b(4); 
%     fit = @(b,t)  b(1) .* exp(- b(2) * t) .* sin((2*pi*(t - b(4)))/b(3));
%     fcn = @(b) sum((fit(b,t) - y).^2); 
%     sol = fminsearch(fcn, [k_init;  d_init;  T_init; t0_init]);
    
    % sol is now [k,  d,  T, t0]
%     test = sol(1) .* exp(- sol(2) * t) .* sin(2 * pi * (t-sol(4)) / sol(3));
    pos_damping(i) = pos_exp_fit(2);
    neg_damping(i) = neg_exp_fit(2);
    
    %subplot(size(files, 1),1,i);
    plot(t, y, pos_peak_loc, pos_damp, neg_peak_loc, neg_damp)
    %line(pos_peak_line_x, pos_peak_line_y, 'Color', 'r')
    %line(neg_peak_line_x, neg_peak_line_y, 'Color', 'r')
    
    % text(pos_peak_loc+.02,pos_peaks,strcat('pos', num2str((1:numel(pos_peaks))')))
    % text(neg_peak_loc+.02,neg_peaks,strcat('neg', num2str((1:numel(neg_peaks))')))
end

pos_damping
neg_damping
