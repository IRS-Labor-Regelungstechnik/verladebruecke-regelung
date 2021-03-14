Organisation des Verzeichnes des LQG - Riccati Regler

--------------------Stand: 14.03.2021---------------------------
Dieses Verzeichnis enth�lt Simulink Modelle und Matlab Funtkionen f�r die Simulation und die Anlage.

Voraussetzung: Vor der Verwendung m�ssen die Parameter mit modell_parameter.m geladen werden.

Simulation:
- Riccati_Simulation.slx: enth�lt das Simulink Modell des gesamten Automatisierungskonzepts bestehend aus P-Regler und Riccati-Regler
	-> Steuerung_Automatisierung.m aus Simulink\Automatisierung muss in das Matlab System Steuerung_Automatisierung geladen werden
- RiccatiBerechnunguPlot_Simulation.m: enth�lt weitere Parameter. Das Ausf�hren startet die Simulation und plottet alle relevanten Gr��en

Anlage:
- RiccatiBerechnung_Anlage.m: Berechnet durch das L�sen der algebraischen Riccati-Gleichung die Reglermatrix K
- RiccatiRegler_Anlage.slx: Simulink Modell des gesamten Automatisierungskonzepts
	-> Steuerung_Automatisierung.m aus Simulink\Automatisierung muss vor der Verwendung in das Matlab System Steuerung_Automatisierung geladen werden
