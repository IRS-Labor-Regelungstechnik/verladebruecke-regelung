% Run modell_parameter.m in Modellierung/Modulare_modelle

swarm_size = 15;
swarm = 200 * rand(5, swarm_size);
vel = -5 + 10 * rand(5, swarm_size);
pbest = swarm(:,randi(swarm_size)); % prev best
iterations = 100;
time_steps = 0:0.1:100;

omega = 0.05;
model_ref = tf([omega^3], [1, 1.75 * omega, 2.15 * omega^2, 1.5 * omega^3]);
[model_resp, model_time] = step(model_ref, time_steps);

time_step = model_time(2) - model_time(1); % Assuming constant time step
end_of_rise_index = find(model_resp>=0.67, 1);

correct_pos_after = model_time(end_of_rise_index) * 1.5; 
corr_pos_index = find(model_time>=correct_pos_after, 1);

end_ind = size(model_resp, 1);

for i = 1:iterations 
    for particle = 1:swarm_size
        part_vec = swarm(:,particle);
        K_PK = part_vec(1);
        K_IK = part_vec(2);
        K_DK = part_vec(3);
        K_filterK = 1/200;
        K_PG = part_vec(4);
        K_DG = part_vec(5);
        K_filterG = 1/200;
        R_1 = pid(K_PK, K_IK, K_DK, 1);
        R_3 = pid(K_PG, 0, K_DG);
        
        tf_1 = F_o * G_1 / (1 + F_o * G_1);
        tf_3 = F_o * G_3 / (1 + F_o * G_3);
        
        [resp_1, t_1] = step(tf_1, time_steps);
        [resp_3, t_3] = step(tf_3, time_steps);
        
        diff_from_model = resp_1 - model_resp;
        rise_error = sum(time_step .* diff_from_model(1:end_of_rise_index).^2);
        swing_error = sum(time_step .* resp_3(end_of_rise_index+1:end_ind).^2);
        pos_corr_errorsum(time_step .* diff_from_model(correct_pos_after:end_ind).^2);
    end
end 

