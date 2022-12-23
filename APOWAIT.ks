//Приближаемся к апоцентру

PRINT "Waiting for apoapsis".

lock steering to prograde.

UNTIL ETA:APOAPSIS < 1
{
	CLEARSCREEN.
	PRINT "ETA:APO: " + ETA:APOAPSIS.
	If ETA:Apoapsis<15 {set kuniverse:timewarp:warp to 0.}
}