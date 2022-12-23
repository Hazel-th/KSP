set the_mun to body("Mun").
set StopBurn to false.
UNTIL StopBurn {
	LOCK STEERING TO HEADING(90,0).
	IF (ETA:PERIAPSIS < 10){
		LOCK Throttle to 1.
		WAIT 5.
		set StopBurn to true.
	}
	
	
	
}
set Throttle to 0. 