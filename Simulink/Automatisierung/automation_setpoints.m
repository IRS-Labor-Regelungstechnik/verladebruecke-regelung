function [x,y,mag, rest, ...
          horiz_pos_tol, horiz_vel_tol, vert_pos_tol, ...
          vert_vel_tol, angle_tol, angle_vel_tol] = ...
        automation_setpoints(p, add_midpoints, midpoint_height, max_points)
    
    box_x_pos = (p.box_sequence - 1) * p.distance_between_boxes ...
        + p.first_box_to_baseline - p.baseline_to_left_switch ...
        - p.box_width/2;
    box_y_pos = (ones(size(box_x_pos)) * p.gripper_max_length) - p.box_height + p.min_gripper_to_ground;

    goal_x_pos = ones(size(box_x_pos)) * (p.first_box_to_baseline + 4*p.distance_between_boxes + 121.4);
    goal_y_pos = (ones(size(box_x_pos)) * p.gripper_max_length) - ((1:size(box_x_pos, 2)) * p.box_height) ...
        + p.min_gripper_to_ground;
    
    x = zeros(1, max_points);
    y = zeros(1, max_points);
    mag = zeros(1, max_points);  % State of magnet after reaching position
    rest = zeros(1, max_points); % Seconds to rest after reaching position
    
    default_pos_tol = 5;  % cm or deg
    default_vel_tol = 5;  % cm/s or deg/s
    horiz_pos_tol = ones(1, max_points) * default_pos_tol; % All pos tolerances are in cm
    horiz_vel_tol = ones(1, max_points) * default_vel_tol; % All vel tolerances are in cm/s
    vert_pos_tol = ones(1, max_points) * default_pos_tol;
    vert_vel_tol = ones(1, max_points) * default_vel_tol;
    angle_tol = ones(1, max_points) * default_pos_tol;     % deg
    angle_vel_tol = ones(1, max_points) * default_vel_tol; % deg/s
    
    k = 1;
    
    % Start position
    x(k) = p.init_x_pos;
    y(k) = p.init_y_pos;
    mag(k) = 0;
    rest(k) = 2;  
%     horiz_pos_tol(k) = 5;  
%     horiz_vel_tol(k) = 5;  
%     vert_pos_tol(k) = 5;
%     vert_vel_tol(k) = 5;
%     angle_tol(k) = 5;      
%     angle_vel_tol(k) = 5;  
    k = k+1;
    
    x(k) = box_x_pos(1);
    y(k) = p.init_y_pos;
    mag(k) = 0;
    rest(k) = 0;
    k = k+1;
    
    for i = 1:size(box_x_pos, 2)
        if midpoint_height ~= -1
            intermediate_height = midpoint_height;
        else
            intermediate_height = goal_y_pos(i) - (p.box_height + p.add_height_to_midpoints);
        end

        % Grab box here
        x(k) = box_x_pos(i);
        y(k) = box_y_pos(i);
        mag(k) = 1;
        rest(k) = 1;
        k = k+1;
        
        if add_midpoints
            % First midpoint, over box_x
            x(k) = box_x_pos(i);
            y(k) = intermediate_height;
            mag(k) = 1;
            rest(k) = 0;
            k = k+1;

            % Second midpoint, over goal_x
            x(k) = goal_x_pos(i);
            y(k) = intermediate_height;
            mag(k) = 1;
            rest(k) = 0;
            k = k+1;
        end

        % Let go of box at goal
        x(k) = goal_x_pos(i);
        y(k) = goal_y_pos(i);
        mag(k) = 0;
        rest(k) = 1;
        k = k+1;

        if add_midpoints
            % Third midpoint, over goal_x
            x(k) = goal_x_pos(i);
            y(k) = intermediate_height;
            mag(k) = 0;
            rest(k) = 0;
            k = k+1;

            % Fourth midpoint, over box_x+1
            if i < size(box_x_pos, 2)
                x(k) = box_x_pos(i+1);
            else
                x(k) = p.init_x_pos;
            end
            y(k) = intermediate_height;
            mag(k) = 0;
            rest(k) = 0;
            k = k+1;
        end
    end
    x(k) = p.init_x_pos;
    y(k) = p.init_y_pos;
    mag(k) = 0;
    rest(k) = 0;
end 