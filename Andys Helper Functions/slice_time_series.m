function ts = slice_time_series(ts_in, start_time, end_time)
% schneide bestimmte Bereich aus ts_in aus
% ts_in must have size 2xN with first row being time stamps

start_index = find(ts_in(1,:)>start_time, 1);
end_index = find(ts_in(1,:)>end_time, 1);
if isempty(start_index)
    start_index = 1;
end
if isempty(end_index)
    end_index = size(ts_in, 2);
end
ts = ts_in(:,start_index:end_index);
ts(1,:) = ts(1,:) - ts(1,1);
end