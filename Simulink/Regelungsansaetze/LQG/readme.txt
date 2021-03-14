Organisation des Verzeichnes des LQG - Riccati Regler

--------------------Stand: 14.03.2021---------------------------
Dieses Verzeichnis enthält Simulink Modelle und Matlab Funtkionen für die Simulation und die Anlage.

Voraussetzung: Vor der Verwendung müssen die Parameter mit modell_parameter.m geladen werden.

Simulation:
- Riccati_Simulation.slx: enthält das Simulink Modell des gesamten Automatisierungskonzepts bestehend aus P-Regler und Riccati-Regler
	-> Steuerung_Automatisierung.m aus Simulink\Automatisierung muss in das Matlab System Steuerung_Automatisierung geladen werden
- RiccatiBerechnunguPlot_Simulation.m: enthält weitere Parameter. Das Ausführen startet die Simulation und plottet alle relevanten Größen

Anlage:
- RiccatiBerechnung_Anlage.m: Berechnet durch das Lösen der algebraischen Riccati-Gleichung die Reglermatrix K
- RiccatiRegler_Anlage.slx: Simulink Modell des gesamten Automatisierungskonzepts
	-> Steuerung_Automatisierung.m aus Simulink\Automatisierung muss vor der Verwendung in das Matlab System Steuerung_Automatisierung geladen werden
