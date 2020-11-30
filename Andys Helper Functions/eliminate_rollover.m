function rollovers = eliminate_rollover(var_in)
    % var_in must be 1xN in size
    shifted = var_in(2:size(var_in, 2));
    diff = shifted - var_in(1:size(var_in, 2)-1);
    neg_rollovers = diff > 300;
    sum_neg_rollovers = cumsum(neg_rollovers) * -360;
    pos_rollovers = diff < -300;
    sum_pos_rollovers = cumsum(pos_rollovers) * 360;
    sum_rollovers = sum_neg_rollovers + sum_pos_rollovers;
    rollovers = var_in + [0 sum_rollovers];
end