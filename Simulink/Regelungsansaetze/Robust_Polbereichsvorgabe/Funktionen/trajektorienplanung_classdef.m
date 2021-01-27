classdef trajektorienplanung_classdef < matlab.System
    % Untitled Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.

    % Public, tunable properties
    properties

    end

    properties(DiscreteState)
        
    end

    % Pre-computed constants
    properties(Access = private)
        
    end

    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
            
        end

        function [x_sollgroesse, y_sollgroesse, regler_an] = stepImpl(~,horiz_setpoint,vert_setpoint,control_enable)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            
            x_sollgroesse = horiz_setpoint;
            
            y_sollgroesse = vert_setpoint;
            
            regler_an = control_enable;
            
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            
        end
    end
end
