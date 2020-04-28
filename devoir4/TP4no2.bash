#!/bin/bash
#TP4no2.bash script
ligne="TP1(80),Intra(80),TP2(80),TP3(80),Final(40),TP4(80)"
chaine=$ligne
TP1=50
Intra=50
TP2=50
TP3=50
Final=51
TP4=50
Total=0
function calculTotal
{
	Total=`echo "scale=4; $Total+($TP1+$TP2+$TP3+$TP4)*7.5"|bc`
	Total=`echo "scale=4; $Total+$Intra*30"|bc`
	Total=`echo "scale=4; $Total+$Final*40"|bc`
	Total=`echo "scale=4; $Total/100"|bc`
	echo $Total
}
function extraction
{
	chaine=${chaine#*(}
	TP1=${chaine%%)*}
	chaine=${chaine#*(}
	Intra=${chaine%%)*}
	chaine=${chaine#*(}
	TP2=${chaine%%)*}
	chaine=${chaine#*(}
	TP3=${chaine%%)*}
	chaine=${chaine#*(}
	Final=${chaine%%)*}
	chaine=${chaine#*(}
	TP4=${chaine%%)*}
}
extraction
calculTotal