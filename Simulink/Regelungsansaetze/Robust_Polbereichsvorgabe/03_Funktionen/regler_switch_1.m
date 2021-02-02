classdef regler_switch_1 < matlab.System
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

        function [y] = stepImpl(~,regler_on,input)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            
            if (regler_on == 1)
            	y = input;
            else
                y = 0;
            end
            
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            
        end
    end
end
