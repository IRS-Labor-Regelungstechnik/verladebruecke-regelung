classdef trajektorienplanung_classdef < matlab.System
    % Untitled Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.

    % Public, tunable properties
    properties
        
    end

    properties(DiscreteState)
        %kiste_num
    end

    % Pre-computed constants
    properties(Access = private)
        
    end

%      methods
%         % Constructor
%         function obj = trajektorienplanung_classdef(varargin)
%             % Support name-value pair arguments when constructing object
%             setProperties(obj,nargin,varargin{:});
%         end
%     end
    
    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
            %obj.kiste_num = 1;
        end

        function [x_sollgroesse, y_sollgroesse, regler_an] = stepImpl(obj,horiz_setpoint,vert_setpoint,control_enable)%,kiste_num)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            
            regler_an = control_enable;
            x_sollgroesse = horiz_setpoint;
            y_sollgroesse = vert_setpoint;
            
%             if kiste_num == 0
%                 x_sollgroesse = horiz_setpoint;
%                 y_sollgroesse = vert_setpoint;
%             elseif kiste_num == 1
%                 
%             elseif kiste_num == 2
%                 
%             elseif kiste_num == 3
%                 
%             elseif kiste_num == 4
%                 
%             elseif kiste_num == 5
%                 
%             end
            
            
            
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            
        end
        
%         function s = saveObjectImpl(obj)
%             % Set properties in structure s to values in object obj
% 
%             % Set public properties and states
%             s = saveObjectImpl@matlab.System(obj);
% 
%             % Set private and protected properties
%             %s.myproperty = obj.myproperty;
%         end
        
%         function loadObjectImpl(obj,s,wasLocked)
%             % Set properties in object obj to values in structure s
% 
%             % Set private and protected properties
%             % obj.myproperty = s.myproperty; 
% 
%             % Set public properties and states
%             loadObjectImpl@matlab.System(obj,s,wasLocked);
%         end
    end
end
