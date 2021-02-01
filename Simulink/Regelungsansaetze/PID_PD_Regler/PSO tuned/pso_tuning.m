% Run modell_parameter.m in Modellierung/Modulare_modelle

swarm_size = 15;

% First five rows are the parameters, then one row personal bests and
% another is the fitness value J
swarm = 0.001 * [rand(5, swarm_size); 100000000 * ones(1, swarm_size)];
vel = -0.05 + 0.1 * rand(5, swarm_size);
pbest = swarm(:,randi(swarm_size)); % prev best particle
gbest = 1000000 * ones(6, 1);
iterations = 100;
time_steps = 0:0.1:100;

omega = 0.5;
model_ref = tf([omega^3], [1, 1.75 * omega, 2.15 * omega^2, 1.5 * omega^3]);
% step(model_ref, time_steps)
[model_resp, model_time] = step(model_ref, time_steps);

time_step = model_time(2) - model_time(1); % Assuming constant time step
end_of_rise_index = find(model_resp>=0.67, 1);

correct_pos_after = model_time(end_of_rise_index) * 1.5; 
corr_pos_index = find(model_time>=correct_pos_after, 1);

end_ind = size(model_resp, 1);

inertia = linspace(0.9,0.4,iterations);

for i = 1:iterations 
    for particle = 1:swarm_size
        part_vec = swarm(1:5,particle);
        K_PK = part_vec(1);
        K_IK = part_vec(2);
        K_DK = part_vec(3);
        K_filterK = 1/200;
        K_PG = part_vec(4);
        K_DG = part_vec(5);
        K_filterG = 1/200;
        R_1 = pid(K_PK, K_IK, K_DK, 1);
        R_3 = pid(K_PG, 0, K_DG);
        
        F_o = R_1 / (1- G_3 * R_3);
        tf_1 = F_o * G_1 / (1 + F_o * G_1);
        tf_3 = F_o * G_3 / (1 + F_o * G_3);
        
%         temp = pole(tf_1);
%         temp(real(temp) > 0)
%         temp2 = pole(tf_3);
%         temp2(real(temp2) > 0)
        
        if any(real(pole(tf_1)) > 0) || any(real(pole(tf_3)) > 0.00001)
            swarm(6,particle) = 10000000;
        else
            [resp_1, t_1] = step(tf_1, time_steps);
            [resp_3, t_3] = step(tf_3, time_steps);

            diff_from_model = resp_1 - model_resp;
            rise_error = sum(diff_from_model(1:end_of_rise_index).^2);
            swing_error = sum(t_3(end_of_rise_index+1:end_ind) .* resp_3(end_of_rise_index+1:end_ind).^2);
            pos_corr_error = sum(t_3(corr_pos_index:end_ind) .* (resp_3(corr_pos_index:end_ind)- 1).^2);
            % pos_corr_error = sum(diff_from_model(corr_pos_index:end_ind).^2);
            
            swarm(6,particle) = rise_error + swing_error + pos_corr_error;
        end
        
        hold on
        plot(i, swarm(6,particle), 'o')
    end
    
    [min_val, min_index] = min(swarm(6,:));
    pbest = swarm(:,min_index);
 
    if min_val < gbest(6)
        gbest = swarm(:, min_index);
        gbest(6)
    end

    delta_v = 2*rand().*(pbest - swarm) + 2*rand().*(gbest - swarm);
    vel = inertia(i) .* vel + delta_v(1:5, swarm_size);
    swarm = swarm + [vel; zeros(1, swarm_size)];
end 

R_1 = pid(gbest(1), gbest(2), gbest(3), 1);
R_3 = pid(gbest(4), 0, gbest(5));

F_o = R_1 / (1- G_3 * R_3);
tf_1 = F_o * G_1 / (1 + F_o * G_1);
tf_3 = F_o * G_3 / (1 + F_o * G_3);

