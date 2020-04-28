#!/bin/bash
#TP4no1.bash script
n=$1
nm2=1
nm1=1
f=1
i=2
while [ $i -le $n ]; do
	f=$(($nm2+$nm1))
	nm2=$nm1
	nm1=$f
	i=$(($i+1))
done
echo $f