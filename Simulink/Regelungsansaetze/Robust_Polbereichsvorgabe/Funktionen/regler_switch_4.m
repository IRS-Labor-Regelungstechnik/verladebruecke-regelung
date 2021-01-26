classdef regler_switch_4 < matlab.System
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

        function [y1, y2, y3, y4] = stepImpl(~,regler_on,input1,input2,input3,input4)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            
            if (regler_on == 1)
            	y1 = input1;
                y2 = input2;
                y3 = input3;
                y4 = input4;
            else
                y1 = 0;
                y2 = 0;
                y3 = 0;
                y4 = 0;
            end
            
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            
        end
    end
end
