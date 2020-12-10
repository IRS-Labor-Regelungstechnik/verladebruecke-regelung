classdef Teaching < matlab.System & matlab.system.mixin.Propagates
    % Teaching Skript zum automatisierten Teaching der Absolutwertdrehgeber
    %
    % Laufkatze bzw. Greifer muss sich zum Start ungef?hr in der Mitte befinden
    
    % Public, tunable properties
    properties
        % Minimale Fahrtdauer in Sekunden, bis ein Ende der Strecke
        % erreicht wird
        dauer_start_zu_endpunkt = 40;
        
        % Motordrehzahl-Vorgabe in Volt
        motor_drehzahl = 0.01;
    end
    
    properties(Nontunable)
        
    end
    
    properties(DiscreteState)
        
    end
    
    % Pre-computed constants
    properties(Access = private)
        time0
        time1
        time2
        time3
        time_set0
        time_set1
        time_set2
        time_set3
        
        Schritt2
        Schritt3
        Schritt4
        Schritt5
        
        prop_n_Motor
        prop_Abswertgeber_Set
    end
    
    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
            obj.time0 = 0;
            obj.time1 = 0;
            obj.time2 = 0;
            obj.time3 = 0;
            obj.time_set0 = 0;
            obj.time_set1 = 0;
            obj.time_set2 = 0;
            obj.time_set3 = 0;
            
            obj.Schritt2 = false;
            obj.Schritt3 = false;
            obj.Schritt4 = false;
            obj.Schritt5 = false;
            
            obj.prop_n_Motor = 0;
            obj.prop_Abswertgeber_Set = 0;
        end
        
        function [Motor_DAC, AWG_Set, Finished] = stepImpl(obj, Start, Clock)
            if ~Start && obj.Schritt5
                obj.Schritt5 = false;
            end
            
            % Teach Vorgang
            if Start && ~obj.Schritt2 && ~obj.Schritt5 % starte Motor
                obj.prop_n_Motor = (-1) * obj.motor_drehzahl;
                if(obj.time_set0 == 0)
                    obj.time_set0 = 1;
                    obj.time0 = Clock;
                end
                
                obj.Schritt2 = true; % Einstellungen fuer Schritt 2 abgeschlossen
            end
            
            if((Clock - obj.time0) >= obj.dauer_start_zu_endpunkt) && obj.Schritt2 && ~obj.Schritt3 % Ende erreicht
                
                obj.prop_n_Motor = 0; % stoppe Motor
                
                obj.prop_Abswertgeber_Set = 1; % setze Abswertgeber_Set auf 1 (siehe Schritt 3)
                if(obj.time_set1 == 0)
                    obj.time_set1 = 1;
                    obj.time1 = Clock;
                end
                
                if((Clock - obj.time1) >= 1.5) %%% von 1 auf 1.5 ge?ndert
                    obj.prop_Abswertgeber_Set = 0; % setze Setausgang nach 1s wieder auf 0
                    obj.Schritt3 = true;
                end
                
            end
            
            
            if((Clock - obj.time1) >= 5) && obj.Schritt3 && ~obj.Schritt4 %%% von 4 auf 5 geaendert
                obj.prop_n_Motor = obj.motor_drehzahl;
                if(obj.time_set3 == 0)
                    obj.time_set3 = 1;
                    obj.time3 = Clock;
                end
                
                obj.Schritt4 = true; % Einstellungen fuer Schritt 4 abgeschlossen
            end
            
            if ((Clock - obj.time3) >= obj.dauer_start_zu_endpunkt) && obj.Schritt4 && ~obj.Schritt5
                obj.prop_n_Motor = 0; % stoppe Motor
                
                obj.prop_Abswertgeber_Set = 1;
                if(obj.time_set2 == 0)
                    obj.time_set2 = 1;
                    obj.time2 = Clock;
                end
                
                if((Clock - obj.time2) >= 2) %%% von 1 auf 2 geaendert
                    obj.prop_Abswertgeber_Set = 0;
                    
                    obj.Schritt5 = true; % Schritt 5 abgeschlossen, Teaching abgeschlossen
                end
                
            end
            
            Finished = obj.Schritt5;
            AWG_Set = obj.prop_Abswertgeber_Set;
            Motor_DAC = obj.prop_n_Motor;
            
        end
        
        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            obj.time0 = 0;
            obj.time1 = 0;
            obj.time2 = 0;
            obj.time3 = 0;
            obj.time_set0 = 0;
            obj.time_set1 = 0;
            obj.time_set2 = 0;
            obj.time_set3 = 0;
            
            obj.Schritt2 = false;
            obj.Schritt3 = false;
            obj.Schritt4 = false;
            obj.Schritt5 = false;
            
            obj.prop_n_Motor = 0;
            obj.prop_Abswertgeber_Set = 0;
        end

        function flag = isInputSizeLockedImpl(obj,index)
            % Return true if input size is not allowed to change while
            % system is running
            flag = true;
        end

        function [Motor_DAC, AWG_Set, Finished] = getOutputSizeImpl(obj)
            % Return size for each output port
            Motor_DAC = [1 1];
            AWG_Set = [1 1];
            Finished = [1 1];
        end

        function [Motor_DAC, AWG_Set, Finished] = getOutputDataTypeImpl(obj)
            % Return data type for each output port
            Motor_DAC = 'double';
            AWG_Set = 'double';
            Finished = 'logical';
        end

        function [Motor_DAC, AWG_Set, Finished] = isOutputComplexImpl(obj)
            % Return true for each output port with complex data
            Motor_DAC = false;
            AWG_Set = false;
            Finished = false;
        end

        function [Motor_DAC, AWG_Set, Finished] = isOutputFixedSizeImpl(obj)
            % Return true for each output port with fixed size
            Motor_DAC = true;
            AWG_Set = true;
            Finished = true;
        end
    end
end
