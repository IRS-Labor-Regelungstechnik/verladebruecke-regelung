classdef Motorsteuerung2 < matlab.System
    % Motorsteuerung2 Add summary here
    %
    % Laufkatze bzw. Greifer muss sich ungefähr in der Mitte befinden

    % Public, tunable properties
    properties
        
    end

    properties(Nontunable)
        
    end

    properties(DiscreteState)
        
    end

    % Pre-computed constants
    properties(Access = private)
        time1
        time2
        time_set1
        time_set2
        
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
            obj.time1 = 0;
            obj.time2 = 0;
            obj.time_set1 = 0;
            obj.time_set2 = 0;
            
            obj.Schritt2 = 0;
            obj.Schritt3 = 0;
            obj.Schritt4 = 0;
            obj.Schritt5 = 0;
            
            obj.prop_n_Motor = 0;
            obj.prop_Abswertgeber_Set = 0;
        end

        function [n_Motor,Abswertgeber_Set] = stepImpl(obj,Schritt1,Resolver_Int,Clock)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            
            %n_Motor = 0;
            %Abswertgeber_Set = 0;
            
            if(Schritt1 == 0) && (Clock > 6) && (obj.Schritt2 == 0) % starte Motor
                obj.prop_n_Motor = -0.05;
                obj.Schritt2 = 1; % Einstellungen für Schritt 2 abgeschlossen
            end
            
            % hier eventuell kritisch falls nicht sofort eine Veränderung
            % des Resolverwinkels eintritt -> 6.5 -> halbe sekunde Zeit
            if(Resolver_Int < 0.1) && (Clock > 6.5) && (obj.Schritt2 == 1) && (obj.Schritt3 == 0) % Ende erreicht
                
                obj.prop_n_Motor = 0; % stoppe Motor
                
                obj.prop_Abswertgeber_Set = 1; % setze Abswertgeber_Set auf 1 (siehe Schritt 3)
                if(obj.time_set1 == 0)
                        obj.time_set1 = 1;
                        obj.time1 = Clock;
                end
                
                if((Clock - obj.time1) >= 1)
                    obj.prop_Abswertgeber_Set = 0; % setze Setausgang nach 1s wieder auf 0
                    obj.Schritt3 = 1;
                end
                
            end
            
            % In Schritt 3 erst 1s HIGH dann 3s warten -> 4s
            if((Clock - obj.time1) >= 4) && (obj.Schritt3 == 1) && (obj.Schritt4 == 0)
                obj.prop_n_Motor = 0.05;
                
                obj.Schritt4 = 1; % Einstellungen für Schritt 4 abgeschlossen
            end
            
            % 4.5: mind. 0.5s nach Start der Motoren
            if(Resolver_Int > -0.1) && ((Clock - obj.time1) >= 4.5) && (obj.Schritt4 == 1) && (obj.Schritt5 == 0)
                
                obj.prop_n_Motor = 0; % stoppe Motor
                
                obj.prop_Abswertgeber_Set = 1;
                if(obj.time_set2 == 0)
                        obj.time_set2 = 1;
                        obj.time2 = Clock;
                end
                
                if((Clock - obj.time2) >= 1)
                    obj.prop_Abswertgeber_Set = 0;
                    
                    obj.Schritt5 = 1; % Schritt 5 abgeschlossen, Teaching abgeschlossen
                end
                
            end
            
            
            Abswertgeber_Set = obj.prop_Abswertgeber_Set;
            n_Motor = obj.prop_n_Motor;
            
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end
    end
end
