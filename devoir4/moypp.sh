#!/bin/sh
# moypp.sh script
#Ce script sert à lire des notes d'étudiants à partir d'un fichier
#liste.csv pour ensuite calculer et écrire les notes finales
#de ces étudiants dans un fichier moy.sh
#Le fichier liste.csv devra être mis en paramètre après sh moy.sh

declare -a notes	#tableau qui contient toutes les notes non-finales des étudiants  
					#0:TP1, 1:Intra, 2:TP2, 3:TP3, 4:Final, 5:TP4
					
function lireNotes	#fonction qui sert à lire les notes à partir de liste.csv
{
	Total="Total"
	>notes.csv	#initialise le fichier notes.csv
	while read ligne
	do
		ligne=${ligne%?}
		chaine=$ligne
		extraction
		ecrireResultat
		Total=0			#réinitialise le total pour une nouvelle ligne
	done < liste.csv
}
function extraction		#sert à extraire les notes des lignes lues
{
	if [ $Total != 0 ]	#met fin à la fonction quand le total n'a pas été réinitialisé
		then
		return 0
	fi
	chaine=${chaine#*,}
	for i in 0 1 2 3 4 5 #0:TP1, 1:Intra, 2:TP2, 3:TP3, 4:Final, 5:TP4
	do
		chaine=${chaine#*,}		#sépare les notes sur la ligne lue afin
		notes[$i]=${chaine%%,*}	#de les mettre dans le tableau notes
	done
	calculTotal
}
function calculTotal	#sert à calculer le total à partir de toutes les notes
{
	TP=`echo "scale=4; ${notes[0]}+${notes[2]}+${notes[3]}+${notes[5]}"|bc`
	Total=`echo "scale=4; $Total+$TP*7.5"|bc`
	Total=`echo "scale=4; $Total+${notes[1]}*30"|bc`
	Total=`echo "scale=4; $Total+${notes[4]}*40"|bc`
	Total=`echo "scale=4; $Total/100"|bc`
	Total=`printf "%g" ${Total/./,}`	#change le format de Total afin de suprimer
										#tous les zéros inutiles
	Total=${Total/,/.}
}
function ecrireResultat	#sert à écrire les notes finales dans notes.csv
{
	chaine=`echo $ligne,$Total`	#reprend la ligne lue et ajoute le total à la fin
	echo $chaine >> notes.csv	#écrit les notes dans notes.csv
}
lireNotes