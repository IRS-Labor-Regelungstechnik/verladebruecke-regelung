% Run modell_parameter.m in Modellierung/Modulare_modelle

swarm_size = 1000;

very_large = 100000000;

iterations = 1000;
time_steps = 0:0.01:20;
last_second = 900:1001;
epsilon_steady_state = 0.05; % Tolerated deviation from steady state during last_second
epsilon_swing = 0.01; % Tolerated swing amplitude during last_second

nr_err = 3; % nr of error metrics
all_sse = zeros(swarm_size, iterations);
all_os = zeros(swarm_size, iterations);
all_sw = zeros(swarm_size, iterations);

all_pbest = zeros(5 + nr_err,iterations);

% +- bounds for pos, vel
bound1 = [0.0005, 0.005];

pid_init = [0.28; 0.183; 0.04];
pd_init = -0.001 * [5;5];

swarm = [1*rand(3, swarm_size);% pid_init * ones(1, swarm_size); % * ((rand(1, swarm_size)-0.5) + 1);
         ((rand(2, swarm_size)-0.5) + 1);
         very_large * ones(nr_err, swarm_size)];

vel = 0.01*(rand()-0.5) * swarm(1:5, :);


%init = bound1;
%swarm = [-init(1) + 2*init(1) * rand(5, swarm_size); very_large * ones(nr_err, swarm_size)];
% vel = -init(2) + 2*init(2) * rand(5, swarm_size);
pbest = swarm(:,randi(swarm_size)); % prev best particle
gbest = swarm(:,randi(swarm_size));

inertia = linspace(0.9,0.4,iterations);

stable_configs = [[0.0103, 0.079, 0.5394, 1.4120, 1.0751, 985.3412, 5271.2, 25.04]'];

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
            swarm(6:(5+nr_err),particle) = very_large;
        else
            [resp_1, t_1] = step(tf_1, time_steps);
            [resp_3, ~] = step(tf_3, time_steps);

            end_of_rise_time = t_1(find(resp_1 > 1, 1));
            if isempty(end_of_rise_time)
                end_of_rise_time = 100;
            end
                        
            sse_err = sum(((t_1(t_1 > end_of_rise_time)./end_of_rise_time).*(resp_1(t_1 > end_of_rise_time) - 1)).^2);
            os_err = sum((10*(resp_1(resp_1 > 1) - 1)).^2);
            swing_err = sum(((t_1(t_1 > end_of_rise_time)./end_of_rise_time).*resp_3(t_1 > end_of_rise_time)).^2);

            all_sse(particle, i) = sse_err;
            all_os(particle, i) = os_err;
            all_sw(particle, i) = swing_err;

            swarm(6:(5+nr_err), particle) = [sse_err; os_err; swing_err];
        end
    end

    [min_val, min_index] = min(sum(swarm(6:(5+nr_err),:), 1));
      
    assert(min_val < very_large || i > 1, 'No stable configs found in first iteration');
    
    pbest = swarm(:,min_index);
    
    indexes_to_rep = sum(swarm(6:(5+nr_err),:), 1) > very_large;
    stable_config = ~indexes_to_rep;

    stable_configs = [stable_configs, swarm(:, stable_config)];
    
    if ~isempty(stable_configs)
        % all instable particles must be replaced
        replace_with = ...
            randsample(1:size(stable_configs, 2), ...
                       size(find(indexes_to_rep), 2), true, ...
                       1 ./ sum(stable_configs(6:(5+nr_err),:), 1));

        swarm(:, indexes_to_rep) = stable_configs(:, replace_with);
    end
    
    fprintf('Iteration %d  had %d stable configs\n', i, sum(stable_config))

    all_pbest(:, i) = pbest;

    if min_val < sum(gbest(6:(5+nr_err),:))
        gbest = swarm(:, min_index);
        % gbest(6:(5+nr_err),:)
    end

    delta_v = 2*rand().*(pbest - swarm) + 2*rand().*(gbest - swarm);
    vel = inertia(i) .* vel + delta_v(1:5, swarm_size);
    swarm = swarm + [vel; zeros(nr_err, swarm_size)];
    
    if size(stable_configs, 2) > 100
        [~, ind_order]= sort(sum(stable_configs(6:(5+nr_err),:), 1));
        stable_configs = stable_configs(:,ind_order(1:100));
    end
end 
gbest(6:(5+nr_err),:)

K_PK = gbest(1);
K_IK = gbest(2);
K_DK = gbest(3);
K_filterK = 1/200;
K_PG = gbest(4);
K_DG = gbest(5);
K_filterG = 1/200;
R_1 = pid(K_PK, K_IK, K_DK, 1);
R_3 = pid(K_PG, 0, K_DG);

F_o = R_1 / (1- G_3 * R_3);
tf_1 = F_o * G_1 / (1 + F_o * G_1);
tf_3 = F_o * G_3 / (1 + F_o * G_3);

[resp_1, t_1] = step(tf_1, time_steps);
[resp_3, t_3] = step(tf_3, time_steps);

figure(1)
subplot(2,1,1)
plot(t_1, resp_1);
subplot(2,1,2)
plot(t_3, resp_3);

all_pbest = all_pbest(:,2:iterations); % The first pbest sometimes has very_large errors

figure(2)
for j = 1:5
    subplot(5,1,j)
    plot(2:iterations, all_pbest(j, :));
end
figure(3)
for j = 6:(5+nr_err)
    subplot(nr_err,1,j-5)
    plot(2:iterations, all_pbest(j, :));
end


