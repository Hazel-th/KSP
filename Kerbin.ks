LOCK Steering TO PROGRADE.

print "Calculating munar angle...".
WAIT 10.


UNTIL CheckMunAngle
{
	WAIT 1.
	clearscreen.

}
set kuniverse:timewarp:warp to 0.

print "Transfer start!".

SET Man_point TO PROGRADE.

LOCK Steering TO Man_point.
WAIT 5.
set the_Kerbin to body("Kerbin").
UNTIL (ORBIT:Apoapsis)>(the_Kerbin:Altitude + 2000000)
{
	if (orbit:Apoapsis/(the_Kerbin:Altitude + 2000000)<0.9)
	{
		Lock Throttle to 1.
	}
	else{
		Lock Throttle to 0.1.
	}	
}


set SHIP:CONTROL:PILOTMAINTHROTTLE to 0.
set Throttle to 0. WAIT 1.


								

function CalculateMunAngle
{
	SET A1 to (2*body("Mun"):radius + body("Kerbin"):altitude + ship:altitude)/2.
	SET A2 to body("Mun"):radius+body("Kerbin"):altitude.
	return 180*(1 - (A1/A2)^1.5).
}

FUNCTION CheckMunAngle
{
	set VecS to Ship:position-body("Mun"):position.
	set VecM to body("Kerbin"):position-body("Mun"):position.
	set VecHV to VXCL(ship:up:vector, ship:velocity:orbit).
	set VecSM to body("Kerbin"):position-Ship:position.
	set m_angle to CalculateMunAngle.
	set cur_angle to VANG(VecM,VecS).
	if VANG(VecHV,VecSM)>90
		set cur_angle to -cur_angle.
	print "Munar angle: " + m_angle.
	print "Current angle: " + cur_angle.
	return ABS(cur_angle - m_angle) < 3.
}