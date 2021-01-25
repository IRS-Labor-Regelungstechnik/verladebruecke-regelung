classdef Steuerung_Automatisierung < matlab.System
    % Steuerung_Automatisierung The automation procedure block for the gantry crane controller

    % Public, tunable properties
    properties
        % Sequence of boxes to pickup, numbered from left to right
        box_sequence = [1, 2, 3, 4, 5]; 

        start_time = 30;
        % 'true' if midpoints should be given to help prevent collision with other boxes along the way
        add_midpoints = true;
    end

    % Public, non-tunable properties
    properties(Nontunable)
        % Total drivable rail length, in cm
        total_rail_length = 135.8 + 118.2; 
        
        init_x_pos = 127;  %cm, for start and finish positioning
        init_y_pos = 10;  %cm
        
        % Gripper measurements
        gripper_max_length = 137.5;  %cm
        min_gripper_to_ground = 2.5;  %cm        
        
        % A position is considered reached if ...
        % the measured position is within this many cm from the target ...
        horiz_precision = 1; 
        vert_precision = 1;
        angle_thres = 5;  % deg deviation from 180
        % and the horiz, vert, and angular speeds are under a threshold, 
        % in cm/sec and degrees/sec
        horiz_speed_thres = 1;
        vert_speed_thres = 1;
        angle_speed_thres = 15;
        
        
        baseline_to_left_switch = 4.5;  %cm
        first_box_to_baseline = 22;  %cm
        distance_between_boxes = 20;  %cm
        goal_to_last_box = 121.4;  %cm
        
        
        box_height = 11.5;  %cm
        box_width = 11;  %cm
        box_lid_width = 14;  %cm
        
        % When determining midpoints, add this height to the box_height
        add_height_to_midpoints = 3;  %cm
    end

    properties(DiscreteState)
        % For initialization process
        time0

        % For main automation process
        box_x_pos
        box_y_pos

        goal_x_pos
        goal_y_pos

        box_nr
        magnet_on
        midpoint_reached
        horiz_setpoint
        vert_setpoint

        % For both processes
        start_pos_reached
        final_pos_reached
    end

    % Pre-computed constants
    properties(Access = private)
        
    end

    methods
        % Constructor
        function obj = Steuerung_Automatisierung(varargin)
            % Support name-value pair arguments when constructing object
            setProperties(obj,nargin,varargin{:});
        end
    end

    methods(Access = protected)
        %% Common functions        
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
            % For initialization process
            obj.time0 = 0;
            
            % For main automation process
            
            
            
            obj.box_x_pos = (obj.box_sequence - 1) * obj.distance_between_boxes ...
                + obj.first_box_to_baseline - obj.baseline_to_left_switch ...
                - obj.box_width/2;
            obj.box_y_pos = (ones(size(obj.box_x_pos)) * obj.gripper_max_length) - obj.box_height + obj.min_gripper_to_ground;
            
            obj.goal_x_pos = ones(size(obj.box_x_pos)) * (obj.first_box_to_baseline + 4*obj.distance_between_boxes + 121.4);
            obj.goal_y_pos = (ones(size(obj.box_x_pos)) * obj.gripper_max_length) - ((1:size(obj.box_x_pos, 2)) * obj.box_height) ...
                + obj.min_gripper_to_ground;
            
            obj.box_nr = 1;
            obj.magnet_on = false;
            obj.midpoint_reached = false;
            obj.horiz_setpoint = 0;
            obj.vert_setpoint = 0;
            
            obj.start_pos_reached = false;
            obj.final_pos_reached = false;
        end

        function [horiz_setpoint, vert_setpoint, magnet_on, control_enable] = ... 
                stepImpl(obj, horiz_pos, horiz_speed, vert_pos, vert_speed, angle, angle_speed, ... 
                         Clock, k_AWG_K, k_AWG_G)
            
            k_AWG_K = k_AWG_K / 100;  % from V/m to V/cm
            k_AWG_G = k_AWG_G / 100;
            
            horiz_pos = horiz_pos / k_AWG_K;
            horiz_speed = horiz_speed / k_AWG_K;
            vert_pos = vert_pos / k_AWG_G;
            vert_speed = vert_speed / k_AWG_G;
            
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            control_enable = Clock - obj.time0 > obj.start_time;  
            if control_enable && ~obj.final_pos_reached
                if ~obj.start_pos_reached || obj.box_nr > size(obj.box_x_pos, 2)
                    obj.horiz_setpoint = obj.init_x_pos;
                    obj.vert_setpoint = obj.init_y_pos;
                else
                    if obj.magnet_on
                        if obj.add_midpoints && ~obj.midpoint_reached
                            obj.vert_setpoint = obj.box_y_pos(obj.box_nr) - (obj.box_height + obj.add_height_to_midpoints);
                        else
                            obj.horiz_setpoint = obj.goal_x_pos(obj.box_nr);
                            obj.vert_setpoint = obj.goal_y_pos(obj.box_nr);
                        end
                    else
                        obj.horiz_setpoint = obj.box_x_pos(obj.box_nr);
                        obj.vert_setpoint = obj.box_y_pos(obj.box_nr);
                    end
                end

                % Condition for reaching setpoint, values are in mV
                if abs(obj.horiz_setpoint - horiz_pos) < obj.horiz_precision * k_AWG_K && ...
                        abs(obj.vert_setpoint - vert_pos) < obj.vert_precision * k_AWG_G && ...
                        horiz_speed < obj.horiz_speed_thres * k_AWG_K && ... 
                        vert_speed < obj.vert_speed_thres * k_AWG_G && ...
                        abs(angle) < obj.angle_thres && ...
                        angle_speed < obj.angle_speed_thres

                    if ~obj.start_pos_reached
                        obj.start_pos_reached = true; 
                    elseif obj.box_nr > size(obj.box_x_pos, 2) && ~obj.final_pos_reached
                        obj.final_pos_reached = true;
                    else
                        if obj.magnet_on
                            if obj.add_midpoints && ~obj.midpoint_reached
                                obj.midpoint_reached = true;
                            else
                                % Gripper is at goal position
                                obj.magnet_on = false;
                                obj.midpoint_reached = false;
                                obj.box_nr = obj.box_nr + 1;
                            end
                        else
                            % Gripper is at box
                            obj.magnet_on = true;
                        end 
                    end
                end
            end
            
            magnet_on = obj.magnet_on;
            
            horiz_setpoint = k_AWG_K * obj.horiz_setpoint;
            vert_setpoint = k_AWG_G * obj.vert_setpoint; 
            
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            % For initialization process
        end


%         function flag = isInputSizeLockedImpl(obj,index)
%             % Return true if input size is not allowed to change while
%             % system is running
%             flag = true;
%         end

        %% Backup/restore functions
        function s = saveObjectImpl(obj)
            % Set properties in structure s to values in object obj

            % Set public properties and states
            s = saveObjectImpl@matlab.System(obj);

            % Set private and protected properties
            %s.myproperty = obj.myproperty;
        end

        function loadObjectImpl(obj,s,wasLocked)
            % Set properties in object obj to values in structure s

            % Set private and protected properties
            % obj.myproperty = s.myproperty; 

            % Set public properties and states
            loadObjectImpl@matlab.System(obj,s,wasLocked);
        end
    end

    methods(Static, Access = protected)
        function header = getHeaderImpl
            % Define header panel for System block dialog
            header = matlab.system.display.Header(mfilename('class'));
        end

        function groups = getPropertyGroupsImpl
            % Define property section(s) for System block dialog
            % group = matlab.system.display.Section(mfilename('class'));
            groups = matlab.system.display.SectionGroup(...
              'Title','General',...
              'PropertyList',{'box_sequence', 'start_time', 'add_midpoints'});
            
            %lowerGroup = matlab.system.display.SectionGroup(...
            %  'Title','Coefficients', ...
            %  'PropertyList',{'baseline_to_left_switch'});

            %groups = [upperGroup,lowerGroup];
        end
    end
end
