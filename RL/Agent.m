classdef Agent
    properties
        learning_rate
        gamma
        epsilon
        input_dim
        batch_size
        action_space
        mem_size
        eps_end
        eps_dec
        mem_counter
        layers
        layer_graph
        Q_eval
        state_memory
        new_state_memory
        action_memory
        reward_memory
        terminal_memory
    end
    methods
        function obj = Agent(learning_rate, gamma, epsilon, input_dim, batch_size, n_actions, ...
                max_mem_size, eps_end, eps_dec)
            obj.learning_rate = learning_rate;
            obj.gamma = gamma;
            obj.epsilon = epsilon;
            obj.input_dim = input_dim;
            obj.batch_size = batch_size; 
            obj.action_space = 1:n_actions;  % Integer representation of the actions
            obj.mem_size = max_mem_size;  % 100000 is a good value
            obj.eps_end = eps_end;  % ex. 0.01
            obj.eps_dec = eps_dec;  % 5e-4
            
            obj.mem_counter = 0;  % First available memory
            
            obj.layers = [
                featureInputLayer(3,'Normalization','none','Name','state')
                fullyConnectedLayer(24,'Name','CriticStateFC1')
                reluLayer('Name','CriticRelu1')
                fullyConnectedLayer(48,'Name','CriticStateFC2')
                reluLayer('Name','CriticCommonRelu')
                fullyConnectedLayer(3,'Name','output')];
            obj.layer_graph = layerGraph(layers);
            obj.Q_eval = dlnetwork(layer_graph);
            
            obj.state_memory = zeros(obj.mem_size, obj.input_dim);
            obj.new_state_memory = zeros(obj.mem_size, obj.input_dim);
            obj.action_memory = zeros(size(obj.mem_size));
            obj.reward_memory = zeros(size(obj.mem_size));
            obj.terminal_memory = logical(zeros(size(obj.mem_size)));
        end
        function obj = store_transition(obj, state, action, reward, new_state, done)
            index = mod(obj.mem_counter,obj.mem_size); % Position of first unoccupied memory
            obj.state_memory(index,:) = state;
            obj.new_state_memory(index,:) = new_state;
            obj.reward_memory(index) = reward; 
            obj.action_memory(index) = action; 
            obj.terminal_memory(index) = done;
            
            obj.mem_counter = obj.mem_counter + 1;
        end
        function obj = choose_action(obj, observation)
            if random('Uniform',0,1) > obj.epsilon
                actions = obj.Q_eval.forward(dlarray(observation, 'C'))
            else
            end
        end
        function r = plus(o1,o2)
            r = [o1.Value] + [o2.Value];
        end
    end

end
