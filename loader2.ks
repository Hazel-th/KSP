IF (STATUS = "Prelaunch")
{
//Загрузка подпрограмм

COPYPATH("0:/APOWAIT.ks","").
COPYPATH("0:/KERBIN.ks","").
COPYPATH("0:/CIRCLEORBIT.ks","").
COPYPATH("0:/GETAPOAPSIS.ks","").
COPYPATH("0:/MUN2.ks","").
COPYPATH("0:/MUNO.ks","").
COPYPATH("0:/ORBPATCHER.ks","").


RUN GetApoapsis(75000).

RUN APOWAIT.

RUN CircleOrbit.

RUN OrbPatcher.


}