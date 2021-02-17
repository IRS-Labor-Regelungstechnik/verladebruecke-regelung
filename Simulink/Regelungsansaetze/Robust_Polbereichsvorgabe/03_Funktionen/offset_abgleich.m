classdef offset_abgleich < matlab.System
    % Steuerung_Automatisierung The automation procedure block for the gantry crane controller

    % Public, tunable properties
    properties
        %start_seite = 1;
    end

    % Public, non-tunable properties
    properties(Nontunable)        
        
    end

    properties(DiscreteState)
        offset % zuletzt gemessener Offset
        taster_entprellung
    end

    % Pre-computed constants
    properties(Access = private)
        sollwert
    end

%     methods
%         % Constructor
%         function obj = Steuerung_Automatisierung(varargin)
%             % Support name-value pair arguments when constructing object
%             setProperties(obj,nargin,varargin{:});
%         end
%     end

    methods(Access = protected)
        %% Common functions        
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
            obj.offset = 0;
            obj.sollwert = 0.5; % Sollwert in V % TODO!!!
            
            obj.taster_entprellung = -1; % damit auch bei clock = 0 offset abgleich durchgeführt werden kann
        end

        function [output] = stepImpl(obj, input, taster, clock)
            
            if (taster > 0.5) && (clock - obj.taster_entprellung > 1) % taster gedrückt
                obj.taster_entprellung = clock;
                
                obj.offset = input - obj.sollwert; % berechne aktuellen Offset
            end
            
            output = input - obj.offset; % berechne korrigierten Output
            
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            % For initialization process
        end
    end
end
