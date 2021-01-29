classdef rate_limiter_classdef < matlab.System
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
        sample_time
        max_rate
        max_step
        difference
        new_value
        abweichung_rl
    end

    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
            obj.sample_time = 0;
            obj.max_rate = 9.57;
            obj.max_step = 0;
            obj.difference = 0;
            obj.new_value = 0;
            obj.abweichung_rl = 0;
        end

        function [y, rl_integral_out, rl_groesser_y_out] = stepImpl(obj, input, clock, clock_delayed, last_value, deriv, rate_limiter, rl_integral_in, rl_groesser_y_in)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            obj.sample_time = clock-clock_delayed;
            obj.max_step = obj.max_rate * obj.sample_time;
            
            obj.difference = input - last_value;
            if abs(obj.difference) >= obj.max_step % ist Wert des Eingangs im Vergleich zum begrenzten Größe größer als maximale Änderung
                if (obj.difference >= 0) && (deriv >= 0)
                    obj.difference = obj.max_step;
                elseif (obj.difference >= 0) && (deriv < 0) % falls deriv negativ ist: verwende diese Steigung für Output
                    if abs(deriv) >= abs(obj.max_rate)
                        obj.difference = (-1) * obj.max_step;
                    else
                        obj.difference = deriv * obj.sample_time; % deriv ist negativ -> difference ist negativ
                    end
                elseif (obj.difference < 0) && (deriv < 0)
                    obj.difference = (-1) * obj.max_step;
                elseif (obj.difference < 0) && (deriv >= 0) % falls deriv positiv ist: verwende diese Steigung für Output
                    if abs(deriv) >= abs(obj.max_rate)
                        obj.difference = obj.max_step;
                    else
                        obj.difference = deriv * obj.sample_time; % deriv ist positiv -> difference ist positiv
                    end
                end
            end
            
            % Falls abstand zu echtem rate limiter zu groß wird steige bis
            % auf wert von rate limiter
            if rl_integral_in > 1
                obj.difference = obj.max_step;
            end
            
            obj.new_value = obj.difference + last_value;
            y = obj.new_value;
            
            % intergriere Abweichung zu standard rate limiter
            if (rate_limiter > y) && (rl_groesser_y_in == 0)
                rl_integral_out = 0;
            elseif (rate_limiter <= y) && (rl_groesser_y_in == 1)
                rl_integral_out = 0;
            else
                obj.abweichung_rl = (rate_limiter - y) * obj.sample_time;
                rl_integral_out = rl_integral_in + obj.abweichung_rl;
            end
            
            if rate_limiter > y
                rl_groesser_y_out = 1;
            else
                rl_groesser_y_out = 0;
            end
            
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            obj.sample_time = 0;
            obj.max_rate = 9.57;
            obj.max_step = 0;
            obj.difference = 0;
            obj.new_value = 0;
            obj.abweichung_rl = 0;
        end
    end
end
