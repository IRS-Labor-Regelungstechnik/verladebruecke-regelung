classdef Automatisierung < matlab.System & matlab.system.mixin.Propagates ...
        & matlab.system.mixin.CustomIcon
    % Automatisierung THe automation block for the gantry crane controller

    % Public, tunable properties
    properties
        % Sequence of boxes to pickup, numbered from left to right
        box_sequence = [1, 2, 3, 4, 5]; 
        % 'true' or '1' if the absolute rotation encoder should be teached before running
        needs_teaching = false;
    end

    % Public, non-tunable properties
    properties(Nontunable)
        % length_schiene = 135.8 + 118.2;  %cm
        baseline_to_left_switch = 4.5;  %cm
        first_box_to_baseline = 22;  %cm
        distance_between_boxes = 20;  %cm
        goal_to_last_box = 121.4;  %cm
        box_height = 11.5;  %cm
        box_width = 11;  %cm
        box_lid_width = 14;  %cm
    end

    properties(DiscreteState)
        magnet_on; 
        box_nr;  % is the index for the current item im box_positions
        on_way_to_goal;  % True when gripper needs to move box to goal
        is_initializing;  % True at beginning
    end

    % Pre-computed constants
    properties(Access = private)
        
    end

    methods
        % Constructor
        function obj = Automatisierung(varargin)
            % Support name-value pair arguments when constructing object
            setProperties(obj,nargin,varargin{:});
        end
    end

    methods(Access = protected)
        %% Common functions
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
            obj.box_positions = (obj.box_sequence - 1) * obj.distance_between_boxes ...
                + obj.first_box_to_baseline - obj.baseline_to_left_switch ...
                - obj.box_width/2;
            obj.goal_position = obj.first_box_to_baseline + 4*obj.distance_between_boxes + 121.4;
            
            obj.box_nr = 1;
            obj.magnet_on = false;
            obj.on_way_to_goal = false;
            obj.is_initializing = true; 
        end

        function [weg_awg_soll, hub_awg_soll, magnet_sig] = stepImpl(obj, weg_awg, hub_awg, winkel)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            weg_awg_soll = weg_awg;
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            obj.box_nr = 1;
            obj.magnet_on = false;
            obj.on_way_to_goal = false;
            obj.is_initializing = true; 
        end

        %% Backup/restore functions
%         function s = saveObjectImpl(obj)
%             % Set properties in structure s to values in object obj
% 
%             % Set public properties and states
%             s = saveObjectImpl@matlab.System(obj);
% 
%             % Set private and protected properties
%             %s.myproperty = obj.myproperty;
%         end
% 
%         function loadObjectImpl(obj,s,wasLocked)
%             % Set properties in object obj to values in structure s
% 
%             % Set private and protected properties
%             % obj.myproperty = s.myproperty; 
% 
%             % Set public properties and states
%             loadObjectImpl@matlab.System(obj,s,wasLocked);
%         end
% 
%         %% Simulink functions
%         function ds = getDiscreteStateImpl(obj)
%             % Return structure of properties with DiscreteState attribute
%             ds = struct([]);
%         end
% 
%         function flag = isInputSizeLockedImpl(obj,index)
%             % Return true if input size is not allowed to change while
%             % system is running
%             flag = true;
%         end
% 
%         function out = getOutputSizeImpl(obj)
%             % Return size for each output port
%             out = [1 1];
% 
%             % Example: inherit size from first input port
%             % out = propagatedInputSize(obj,1);
%         end
% 
        function icon = getIconImpl(obj)
            % Return text as string or cell array of strings for the System
            % block icon
            icon = mfilename('class'); % Use class name
        end
        
        function [weg_awg, hub_awg, winkel] = getInputNamesImpl(~)
           weg_awg = 'Absolutwertgeber Laufkatze';
           hub_awg = 'Absolutwertgeber Greifer';
           winkel = 'Winkel Greifer';
        end
        function [weg_awg_soll, hub_awg_soll, magnet_sig] = getOutputNamesImpl(~)
           weg_awg_soll = 'Sollwert AWG Laufkatze';
           hub_awg_soll = 'Sollwert AWG Greifer';
           magnet_sig = 'Magnet Signal';
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
              'PropertyList',{'box_sequence', 'needs_teaching'});
            
            %lowerGroup = matlab.system.display.SectionGroup(...
            %  'Title','Coefficients', ...
            %  'PropertyList',{'baseline_to_left_switch'});

            %groups = [upperGroup,lowerGroup];
        end
    end
end
