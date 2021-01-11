classdef Motorsteuerung2 < matlab.System
    % Motorsteuerung2 Skript zum automatisierten Teaching der Absolutwertdrehgeber
    %
    % Laufkatze bzw. Greifer muss sich zum Start ungefähr in der Mitte befinden
    
    % Public, tunable properties
    properties
        
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
            
            obj.Schritt2 = 0;
            obj.Schritt3 = 0;
            obj.Schritt4 = 0;
            obj.Schritt5 = 0;
            
            obj.prop_n_Motor = 0;
            obj.prop_Abswertgeber_Set = 0;
        end
        
        function [n_Motor,Abswertgeber_Set] = stepImpl(obj,Schritt1,Clock)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            
            %Parameter
            motor_drehzahl = 0.01;
            dauer_start_zu_endpunkt = 70; % sekunden % bei x-Richtung: 70sek, y-Richtung (Hub): 100sek
            
            
            % Teach Vorgang
            if(Schritt1 == 0) && (Clock > 36.5) && (obj.Schritt2 == 0) % starte Motor
                obj.prop_n_Motor = (-1) * motor_drehzahl;
                if(obj.time_set0 == 0)
                    obj.time_set0 = 1;
                    obj.time0 = Clock;
                end
                
                obj.Schritt2 = 1; % Einstellungen für Schritt 2 abgeschlossen
            end
            
            if((Clock - obj.time0) >= dauer_start_zu_endpunkt) && (obj.Schritt2 == 1) && (obj.Schritt3 == 0) % Ende erreicht
                
                obj.prop_n_Motor = 0; % stoppe Motor
                
                obj.prop_Abswertgeber_Set = 1; % setze Abswertgeber_Set auf 1 (siehe Schritt 3)
                if(obj.time_set1 == 0)
                    obj.time_set1 = 1;
                    obj.time1 = Clock;
                end
                
                if((Clock - obj.time1) >= 1.5) %%% von 1 auf 1.5 geändert
                    obj.prop_Abswertgeber_Set = 0; % setze Setausgang nach 1s wieder auf 0
                    obj.Schritt3 = 1;
                end
                
            end
            
            % In Schritt 3 erst 1s HIGH dann 3s warten -> 4s
            if((Clock - obj.time1) >= 5) && (obj.Schritt3 == 1) && (obj.Schritt4 == 0) %%% von 4 auf 5 geändert
                obj.prop_n_Motor = motor_drehzahl;
                if(obj.time_set3 == 0)
                    obj.time_set3 = 1;
                    obj.time3 = Clock;
                end
                
                obj.Schritt4 = 1; % Einstellungen für Schritt 4 abgeschlossen
            end
            
            if((Clock - obj.time3) >= dauer_start_zu_endpunkt) && (obj.Schritt4 == 1) && (obj.Schritt5 == 0)
                
                obj.prop_n_Motor = 0; % stoppe Motor
                
                obj.prop_Abswertgeber_Set = 1;
                if(obj.time_set2 == 0)
                    obj.time_set2 = 1;
                    obj.time2 = Clock;
                end
                
                if((Clock - obj.time2) >= 2) %%% von 1 auf 2 geändert
                    obj.prop_Abswertgeber_Set = 0;
                    
                    obj.Schritt5 = 1; % Schritt 5 abgeschlossen, Teaching abgeschlossen
                end
                
            end
            
            
            Abswertgeber_Set = obj.prop_Abswertgeber_Set;
            n_Motor = obj.prop_n_Motor;
            
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
            
            obj.Schritt2 = 0;
            obj.Schritt3 = 0;
            obj.Schritt4 = 0;
            obj.Schritt5 = 0;
            
            obj.prop_n_Motor = 0;
            obj.prop_Abswertgeber_Set = 0;
        end
    end
end
