#!/bin/bash
#TP4no2.bash script
ligne=",,80,80,80,80,40,80"
chaine=$ligne
declare -a notes  #0:TP1, 1:Intra, 2:TP2, 3:TP3, 4:Final, 5:TP4
Total=0
function lireNotes
{
	Total="Total"
	while read ligne
	do
		echo $ligne
	done < liste.csv
}
function extraction
{
	chaine=${chaine#*,}
	for i in 0 1 2 3 4 5 #0:TP1, 1:Intra, 2:TP2, 3:TP3, 4:Final, 5:TP4
	do
		chaine=${chaine#*,}
		notes[$i]=${chaine%%,*}
	done
}
function calculTotal
{
	TP=`echo "scale=4; ${notes[0]}+${notes[2]}+${notes[3]}+${notes[5]}"|bc`
	Total=`echo "scale=4; $Total+$TP*7.5"|bc`
	Total=`echo "scale=4; $Total+${notes[1]}*30"|bc`
	Total=`echo "scale=4; $Total+${notes[4]}*40"|bc`
	Total=`echo "scale=4; $Total/100"|bc`
	Total=`printf "%g" ${Total/./,}`
	Total=${Total/,/.}
	echo $Total
}
function écrireRésultat
{
	chaine=`echo $ligne,$Total`
	echo $chaine > notes.csv
	echo $chaine
}
extraction
calculTotal
écrireRésultat
lireNotes