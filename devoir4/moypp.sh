#!/bin/sh
# moypp.sh script
declare -a notes  #0:TP1, 1:Intra, 2:TP2, 3:TP3, 4:Final, 5:TP4
function lireNotes
{
	Total="Total"
	>notes.csv
	while read ligne
	do
		ligne=${ligne%?}
		chaine=$ligne
		extraction
		ecrireResultat
		Total=0
	done < liste.csv
}
function extraction
{
	if [ $Total != 0 ]
		then
		return 0
	fi
	chaine=${chaine#*,}
	for i in 0 1 2 3 4 5 #0:TP1, 1:Intra, 2:TP2, 3:TP3, 4:Final, 5:TP4
	do
		chaine=${chaine#*,}
		notes[$i]=${chaine%%,*}
	done
	calculTotal
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
}
function ecrireResultat
{
	chaine=`echo $ligne,$Total`
	echo $chaine >> notes.csv
}
lireNotes