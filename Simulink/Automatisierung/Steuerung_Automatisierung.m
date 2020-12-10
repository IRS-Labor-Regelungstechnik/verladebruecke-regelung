classdef Steuerung_Automatisierung < matlab.System & matlab.system.mixin.Propagates ...
        & matlab.system.mixin.CustomIcon
    % Steuerung_Automatisierung The automation procedure block for the gantry crane controller

    % Public, tunable properties
    properties
        % Sequence of boxes to pickup, numbered from left to right
        box_sequence = [1, 2, 3, 4, 5]; 
        % 'true' or '1' if the absolute rotation encoder should be teached before running
        needs_teaching = false;
        start_time = 30;
    end

    % Public, non-tunable properties
    properties(Nontunable)
        % Total drivable rail length, in cm
        total_rail_length = 135.8 + 118.2; 
        
        % Total drivable gripper height, in cm
        gripper_max_len = 164;  %cm
        
        % A position is considered reached if ...
        % the measured position is within this many cm from the target ...
        horiz_precision = 1; 
        vert_precision = 1;
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

        % mV-per-cm factor of the horizontal absolute rotary encoder 
        horiz_abs_rot_enc_factor = 39.37; 
        % mV-per-cm factor of the vertical absolute rotary encoder 
        vert_abs_rot_enc_factor = 69.69;  % THIS IS A PLACEHOLDER VALUE
    end

    properties(DiscreteState)
        % For initialization process
        is_initializing 
        do_horiz_teach
        do_vert_teach
        horiz_is_teached
        vert_is_teached
        time0

        % For main automation process
        box_x_pos
        box_y_pos

        goal_x_pos
        goal_y_pos

        box_nr
        magnet_on
        on_way_to_goal
        horiz_setpoint
        vert_setpoint

        % For both processes
        is_positioned
        do_positioning
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
            obj.is_initializing = true; 
            obj.do_horiz_teach = false;
            obj.do_vert_teach = false;
            obj.horiz_is_teached = ~obj.needs_teaching;
            obj.vert_is_teached = ~obj.needs_teaching;
            obj.time0 = 0;
            
            % For main automation process
            obj.box_x_pos = (obj.box_sequence - 1) * obj.distance_between_boxes ...
                + obj.first_box_to_baseline - obj.baseline_to_left_switch ...
                - obj.box_width/2;
            obj.box_y_pos = (ones(size(obj.box_x_pos)) * obj.gripper_max_len) - obj.box_height;
            
            obj.goal_x_pos = ones(size(obj.box_x_pos)) * (obj.first_box_to_baseline + 4*obj.distance_between_boxes + 121.4);
            obj.goal_y_pos = (ones(size(obj.box_x_pos)) * obj.gripper_max_len) - ((1:size(obj.box_x_pos, 2)) * obj.box_height);
            
            obj.box_nr = 1;
            obj.magnet_on = false;
            obj.horiz_setpoint = 0;
            obj.vert_setpoint = 0;
            
            % For both processes
            obj.is_positioned = false;
            obj.do_positioning = false;
        end

        function [horiz_setpoint, vert_setpoint, magnet_on, do_horiz_teach, do_vert_teach, do_positioning, control_enable] = ... 
                stepImpl(obj, horiz_value, horiz_speed, vert_value, vert_speed, angle_speed, horiz_teach_finished, vert_teach_finished, positioning_finished, Clock)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
             
            if Clock - obj.time0 > obj.start_time
                if obj.is_initializing
                    if ~obj.horiz_is_teached
                        if obj.do_horiz_teach && horiz_teach_finished
                            obj.horiz_is_teached = true;
                            obj.do_horiz_teach = false;
                        else
                            obj.do_horiz_teach = true;
                        end
                    else 
                        if ~obj.vert_is_teached
                            if obj.do_vert_teach && vert_teach_finished
                                obj.vert_is_teached = true;
                                obj.do_vert_teach = false;
                            else
                                obj.do_vert_teach = true;
                            end
                        else
                            if ~obj.is_positioned
                                if obj.do_positioning && positioning_finished
                                    obj.is_positioned = true;
                                    obj.do_positioning = false;
                                else
                                    obj.do_positioning = true;
                                end
                            else
                                obj.is_initializing = false;
                            end
                        end
                    end
                else 
                    % Main automation part, initialization is finished! 
                    if obj.box_nr <= size(obj.box_x_pos, 2)
                        if obj.magnet_on
                            obj.horiz_setpoint = obj.horiz_abs_rot_enc_factor * obj.goal_x_pos(obj.box_nr);
                            obj.vert_setpoint = obj.vert_abs_rot_enc_factor * obj.goal_y_pos(obj.box_nr);
                        else
                            obj.horiz_setpoint = obj.horiz_abs_rot_enc_factor * obj.box_x_pos(obj.box_nr);
                            obj.vert_setpoint = obj.vert_abs_rot_enc_factor * obj.box_y_pos(obj.box_nr);
                        end

                        % Condition for reaching setpoint, values are in mV
                        if abs(obj.horiz_setpoint - horiz_value) < obj.horiz_precision * obj.horiz_abs_rot_enc_factor && ...
                                abs(obj.vert_setpoint - vert_value) < obj.vert_precision * obj.vert_abs_rot_enc_factor && ...
                                horiz_speed < obj.horiz_speed_thres * obj.horiz_abs_rot_enc_factor && ... 
                                vert_speed < obj.vert_speed_thres * obj.vert_abs_rot_enc_factor && ...
                                angle_speed < obj.angle_speed_thres

                            if obj.magnet_on
                                % Gripper is at goal position
                                obj.magnet_on = false;
                                obj.box_nr = obj.box_nr + 1;
                            else
                                % Gripper is at box
                                obj.magnet_on = true;
                            end 
                        end
                    else
                        % All boxes have been moved
                        obj.horiz_setpoint = 0;
                        obj.vert_setpoint = 0;
                        if (~obj.is_positioned)
                            if (obj.do_positioning && positioning_finished)
                                obj.is_positioned = true;
                                obj.do_positioning = false;
                            else
                                obj.do_positioning = true;
                            end
                        end
                    end
                end
            end
            
            control_enable = ~obj.is_initializing; 
            do_horiz_teach = obj.do_horiz_teach;
            do_vert_teach = obj.do_vert_teach;
            do_positioning = obj.do_positioning; 
            magnet_on = obj.magnet_on;
            
            horiz_setpoint = obj.horiz_setpoint;
            vert_setpoint = obj.vert_setpoint; 
            
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            % For initialization process
%             obj.is_initializing = true; 
%             obj.do_horiz_teach = false;
%             obj.do_vert_teach = false;
%             obj.horiz_is_teached = ~obj.needs_teaching;
%             obj.vert_is_teached = ~obj.needs_teaching;
%             obj.time0 = 0;
%             
%             % For main automation process
%             obj.box_x_pos = (obj.box_sequence - 1) * obj.distance_between_boxes ...
%                 + obj.first_box_to_baseline - obj.baseline_to_left_switch ...
%                 - obj.box_width/2;
%             obj.box_y_pos = (ones(size(obj.box_x_pos)) * obj.gripper_max_len) - obj.box_height;
%             
%             obj.goal_x_pos = ones(size(obj.box_x_pos)) * (obj.first_box_to_baseline + 4*obj.distance_between_boxes + 121.4);
%             obj.goal_y_pos = (ones(size(obj.box_x_pos)) * obj.gripper_max_len) - ((0:(size(obj.box_x_pos, 2)-1)) * obj.box_height);
%             
%             obj.box_nr = 1;
%             obj.magnet_on = false;
%             obj.horiz_setpoint = 0;
%             obj.vert_setpoint = 0;
%             
%             % For both processes
%             obj.is_positioned = false;
%             obj.do_positioning = false;
        end


        function flag = isInputSizeLockedImpl(obj,index)
            % Return true if input size is not allowed to change while
            % system is running
            flag = true;
        end

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

        %% Simulink functions
        function ds = getDiscreteStateImpl(obj)
            % Return structure of properties with DiscreteState attribute
            ds = struct([]);
        end

        function [out,out2,out3,out4,out5,out6,out7] = isOutputFixedSizeImpl(obj)
            % Return true for each output port with fixed size
            out = true;
            out2 = true;
            out3 = true;
            out4 = true;
            out5 = true;
            out6 = true;
            out7 = true;
        end

        function icon = getIconImpl(obj)
            % Return text as string or cell array of strings for the System
            % block icon
            icon = mfilename('class'); % Use class name
        end

        function [out,out2,out3,out4,out5,out6,out7] = getOutputSizeImpl(obj)
            % Return size for each output port
            out = [1 1];
            out2 = [1 1];
            out3 = [1 1];
            out4 = [1 1];
            out5 = [1 1];
            out6 = [1 1];
            out7 = [1 1];
        end

        function [horiz_setpoint, vert_setpoint, magnet_on, do_horiz_teach, ...
                do_vert_teach, do_positioning, control_enable] = getOutputDataTypeImpl(obj)
            % Return data type for each output port
            horiz_setpoint = 'double';
            vert_setpoint = 'double';
            magnet_on = 'logical';
            do_horiz_teach = 'logical';
            do_vert_teach = 'logical';
            do_positioning = 'logical';
            control_enable = 'logical';
        end

        function [out,out2,out3,out4,out5,out6,out7] = isOutputComplexImpl(obj)
            % Return true for each output port with complex data
            out = false;
            out2 = false;
            out3 = false;
            out4 = false;
            out5 = false;
            out6 = false;
            out7 = false;
        end
        
%         function [weg_awg, hub_awg, winkel] = getInputNamesImpl(~)
%            weg_awg = 'Absolutwertgeber Laufkatze';
%            hub_awg = 'Absolutwertgeber Greifer';
%            winkel = 'Winkel Greifer';
%         end
%         function [weg_awg_soll, hub_awg_soll, magnet_sig] = getOutputNamesImpl(~)
%            weg_awg_soll = 'Sollwert AWG Laufkatze';
%            hub_awg_soll = 'Sollwert AWG Greifer';
%            magnet_sig = 'Magnet Signal';
%         end
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
              'PropertyList',{'box_sequence', 'needs_teaching', 'start_time'});
            
            %lowerGroup = matlab.system.display.SectionGroup(...
            %  'Title','Coefficients', ...
            %  'PropertyList',{'baseline_to_left_switch'});

            %groups = [upperGroup,lowerGroup];
        end
    end
end
