classdef Steuerung_Automatisierung < matlab.System
    % Steuerung_Automatisierung The automation procedure block for the gantry crane controller

    % Public, tunable properties
    properties
        start_time = 30;
        % 'true' if midpoints should be given between end points 
        add_midpoints = true;
        
        % Gripper length for midpoints. Set to -1 for max length that prevents collision with other boxes
        midpoint_height = -1;
    end

    % Public, non-tunable properties
    properties(Nontunable)        
        % Parameter aus modell_parameter.m
        param = struct();
    end

    properties(DiscreteState)
        rest_start
        
        x
        y
        mag
        rest
        x_tol
        x_sp_tol
        y_tol
        y_sp_tol
        ang_tol
        ang_sp_tol
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
            obj.rest_start = 0;
            
            nr_points = 50;

            obj.x = zeros(1, nr_points);
            obj.y = zeros(1, nr_points);
            obj.mag = zeros(1, nr_points);
            obj.rest = zeros(1, nr_points);
            obj.x_tol = zeros(1, nr_points);
            obj.x_sp_tol = zeros(1, nr_points);
            obj.y_tol = zeros(1, nr_points);
            obj.y_sp_tol = zeros(1, nr_points);
            obj.ang_tol = zeros(1, nr_points);
            obj.ang_sp_tol = zeros(1, nr_points);
            
            [obj.x, obj.y, obj.mag, obj.rest, obj.x_tol, obj.x_sp_tol, ...
                obj.y_tol, obj.y_sp_tol, obj.ang_tol, obj.ang_sp_tol] = ...
                automation_setpoints(obj.param, obj.add_midpoints, ...
                                     obj.midpoint_height, nr_points);
            
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
            
            horiz_pos = horiz_pos / (obj.param.k_AWG_K / 100);
            horiz_speed = horiz_speed / (obj.param.k_AWG_K / 100);
            vert_pos = vert_pos / (obj.param.k_AWG_G / 100);
            vert_speed = vert_speed / (obj.param.k_AWG_G / 100);
            
            x_under_thres = false;
            x_speed_under_thres = false;
            y_under_thres = false; 
            y_speed_under_thres = false;
            angle_under_thres = false;
            angle_speed_under_thres = false;
            
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            control_enable = Clock > obj.start_time;  
            if control_enable && obj.x(obj.point_nr) ~= 0 && obj.y(obj.point_nr) ~= 0
                obj.horiz_setpoint = obj.x(obj.point_nr);
                obj.vert_setpoint = obj.y(obj.point_nr);

                x_under_thres = abs(obj.horiz_setpoint - horiz_pos) < obj.x_tol(obj.point_nr);
                x_speed_under_thres = abs(horiz_speed) < obj.x_sp_tol(obj.point_nr);
                y_under_thres = abs(obj.vert_setpoint - vert_pos) < obj.y_tol(obj.point_nr); 
                y_speed_under_thres = abs(vert_speed) < obj.y_sp_tol(obj.point_nr);
                angle_under_thres = abs(angle) < obj.ang_tol(obj.point_nr);
                angle_speed_under_thres = abs(angle_speed) < obj.ang_sp_tol(obj.point_nr);
            
                % Condition for reaching setpoint, values are in mV
                if x_under_thres && x_speed_under_thres && y_under_thres ...
                         && y_speed_under_thres && angle_under_thres && angle_speed_under_thres
                        
                    obj.magnet_on = obj.mag(obj.point_nr);

                    if obj.rest_start == 0
                        obj.rest_start = Clock;
                    end
                    if Clock - obj.rest_start >= obj.rest(obj.point_nr)
                        obj.rest_start = 0;
                        obj.point_nr = obj.point_nr + 1;
                    end
                end
            end
            
            magnet_on = obj.magnet_on;
            horiz_setpoint = (obj.param.k_AWG_K  / 100) * obj.horiz_setpoint;
            vert_setpoint = (obj.param.k_AWG_G / 100) * obj.vert_setpoint; 
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
              'PropertyList',{'start_time', 'add_midpoints', 'midpoint_height', ...
              'param'});
        end
    end
end
