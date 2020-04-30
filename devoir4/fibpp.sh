#!/bin/sh
#fibpp.sh script
#Ce script en Bashe Shell sert à calculer un élément n de la suite Fibonacci
#L'élément n est mis en paramètre après sh fib.sh
n=$1
nm2=1	#n moins 2
nm1=1	#n moins 1
f=1		#somme des éléments de la suite de Fibonacci jusqu'à n
i=2		#variable de loop
while [ $i -le $n ]; do	#loop qui sert à calculer f et qui
	f=$(($nm2+$nm1))	#arrète quand la variable de
	nm2=$nm1			#loop i est plus grande que n
	nm1=$f
	i=$(($i+1))			#i augmente de 1 à chaque loop
done
echo "L'élément $n de la suite Fibonacci a pour valeur $f"