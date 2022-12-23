
//Циркуляризация орбиты с суборбитальной траектории. Должен быть активирован ЖТ двигатель

PRINT "Circle started".

LOCK THROTTLE TO 1.

SET StopBurn TO FALSE.

WHEN STAGE:LIQUIDFUEL < 0.001 THEN {
	PRINT "No liquidfuel. Attempting to stage.".
	STAGE.
	WAIT 1.
	SET ThrIsp TO EngThustIsp.
	PRESERVE.
}.
	
UNTIL StopBurn
{


	SET CirkData to ApoBurn.
	
	if CirkData[4]<0
		set StopBurn to TRUE.	
	else if CirkData[4]<100
		
		LOCK THROTTLE TO MAX(CirkData[4]/100, 0.01).
		LOCK STEERING TO HEADING(90,CirkData[0]).
		
		
	CLEARSCREEN.
	PRINT "Fi: "+CirkData[0].
	PRINT "Vh: "+CirkData[1].
	PRINT "Vz: "+CirkData[2].
	PRINT "Vorb: "+CirkData[3].
	PRINT "DVh: "+CirkData[4].
	PRINT "DeltaA: "+CirkData[5].
	PRINT "Athr:" + AThr.	
}

LOCK THROTTLE TO 0.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
CLEARSCREEN.
PRINT "WE`RE ON ORBIT!".
WAIT 1.


PRINT "Circle finished".


//Функция расчета циркуляризации орбиты
FUNCTION ApoBurn
{
	SET Vh TO VXCL(SHIP:UP:VECTOR,SHIP:VELOCITY:ORBIT):MAG. 
	SET Vz TO SHIP:VERTICALSPEED.
	SET Rad TO SHIP:BODY:RADIUS+SHIP:ALTITUDE.
	SET Vorb TO SQRT(SHIP:BODY:MU/Rad).
	SET g_orb TO SHIP:BODY:MU/Rad^2.
	SET ThrIsp TO EngThustIsp.
	SET AThr to ThrIsp[0]*Throttle/(ship:mass).
	SET ACentr to Vh^2/Rad.
	SET DeltaA to g_orb-ACentr - Max(Min(Vz,2),-2).	
	SET dVh TO Vorb-Vh.
	
	IF (AThr < 0.01)
	{
		SET Fi TO 0.
	}
	ELSE
	{	
		SET sin_fi TO DeltaA/AThr.
		
		IF (sin_fi > 1) 
		{
			SET sin_fi TO 1.
		}
		
		IF (sin_fi < -1) 
		{
			SET sin_fi TO -1.
		}
		
		SET Fi TO arcsin(sin_fi).
	}
	
	RETURN LIST(Fi, Vh, Vz, Vorb, dVh, DeltaA).
}


//Возвращает суммарную тягу и средний Isp по всем активным вдигателям
FUNCTION EngThustIsp
{
	//Создаем пустой лист ens
	SET ens to list().
	ens:clear.
	SET ens_thrust to 0.
	SET ens_isp to 0.
	
	list engines in myengines.
	for en in myengines
	{
		IF en:ignition = TRUE AND en:flameout = FALSE {ens:add(en).}
	}
	
	for en in ens
	{
		SET ens_thrust to ens_thrust +en:availablethrust.
		SET ens_isp TO ens_isp + en:isp.
	}
	
	IF ens:length>0
		RETURN LIST(ens_thrust, ens_isp/ens:length).
	ELSE	
		RETURN LIST(0, 0).	
}