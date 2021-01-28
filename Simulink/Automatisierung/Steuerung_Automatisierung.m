classdef Steuerung_Automatisierung < matlab.System
    % Steuerung_Automatisierung The automation procedure block for the gantry crane controller

    % Public, tunable properties
    properties
        % Sequence of boxes to pickup, numbered from left to right
        box_sequence = [1, 2, 3, 4, 5]; 

        start_time = 30;
        % 'true' if midpoints should be given between end points 
        add_midpoints = true;
        
        % Gripper length for midpoints. Set to -1 for max length that prevents collision with other boxes
        midpoint_height = -1;
        
        % Umrechnungsfaktor Weg [V/cm]
        k_AWG_K = 0.003937;
        
        % Umrechnungsfaktor Hub [V/cm]
        k_AWG_G = 0.007273
    end

    % Public, non-tunable properties
    properties(Nontunable)        
        % A position is considered reached if ...
        % the measured position is within this many cm from the target ...
        horiz_precision = 5; 
        vert_precision = 5;
        angle_thres = 5;  % deg deviation from 180
        % and the horiz, vert, and angular speeds are under a threshold, 
        % in cm/sec and degrees/sec
        horiz_speed_thres = 5;
        vert_speed_thres = 5;
        angle_speed_thres = 15;
        
        % Parameter aus modell_parameter.m
        param = struct();
        
    end

    properties(DiscreteState)
        time0
        
        x
        y
        mag
        point_nr
                
        magnet_on
        horiz_setpoint
        vert_setpoint
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
            obj.time0 = 0;

            obj.x = zeros(1, 50);
            obj.y = zeros(1, 50);
            obj.mag = zeros(1, 50);
            
            [obj.x, obj.y, obj.mag] = automation_setpoints(obj.param, obj.add_midpoints, obj.midpoint_height, 50);
            
            obj.point_nr = 1;
            obj.magnet_on = 0;
            obj.horiz_setpoint = 0;
            obj.vert_setpoint = 0;
        end

        function [horiz_setpoint, vert_setpoint, magnet_on, control_enable, ...
                  x_under_thres, x_speed_under_thres, y_under_thres, ...
                  y_speed_under_thres, angle_under_thres, angle_speed_under_thres] = ... 
                stepImpl(obj, horiz_pos, horiz_speed, vert_pos, vert_speed, angle, angle_speed, ... 
                         Clock)
            
            horiz_pos = horiz_pos / obj.k_AWG_K;
            horiz_speed = horiz_speed / obj.k_AWG_K;
            vert_pos = vert_pos / obj.k_AWG_G;
            vert_speed = vert_speed / obj.k_AWG_G;
            
            x_under_thres = false;
            x_speed_under_thres = false;
            y_under_thres = false; 
            y_speed_under_thres = false;
            angle_under_thres = false;
            angle_speed_under_thres = false;
            
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            control_enable = Clock - obj.time0 > obj.start_time;  
            if control_enable && obj.x(obj.point_nr) ~= 0 && obj.y(obj.point_nr) ~= 0
                obj.horiz_setpoint = obj.x(obj.point_nr);
                obj.vert_setpoint = obj.y(obj.point_nr);

                x_under_thres = abs(obj.horiz_setpoint - horiz_pos) < obj.horiz_precision;
                x_speed_under_thres = abs(horiz_speed) < obj.horiz_speed_thres;
                y_under_thres = abs(obj.vert_setpoint - vert_pos) < obj.vert_precision; 
                y_speed_under_thres = abs(vert_speed) < obj.vert_speed_thres;
                angle_under_thres = abs(angle) < obj.angle_thres;
                angle_speed_under_thres = abs(angle_speed) < obj.angle_speed_thres;
            
                % Condition for reaching setpoint, values are in mV
                if x_under_thres && x_speed_under_thres && y_under_thres ...
                         && y_speed_under_thres && angle_under_thres && angle_speed_under_thres
                        
                    obj.magnet_on = obj.mag(obj.point_nr);
                    obj.point_nr = obj.point_nr + 1;
                end
            end
            
            magnet_on = obj.magnet_on;
            horiz_setpoint = obj.k_AWG_K * obj.horiz_setpoint;
            vert_setpoint = obj.k_AWG_G * obj.vert_setpoint; 
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            % For initialization process
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
              'PropertyList',{'box_sequence', 'start_time', 'add_midpoints', 'midpoint_height', ...
              'k_AWG_K', 'k_AWG_G', 'param'});
        end
    end
end
