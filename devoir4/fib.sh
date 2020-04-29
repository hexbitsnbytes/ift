#!/bin/bash
# This script returns an element of the fibonnaci sequence based on 
# its position, provided as a script argument
f0=0
f1=1
arg=${1}
fib_array=(1)

# Implements fibonnaci iterative algorithm
# Returns an element of fibonnaci based on index
fibonnaci() {
    for (( i=0; i<1000; i++ )); do
	    fib=$(( ${f0} + ${f1}))
	    f0=$f1
	    f1=$fib
	    #echo "Value of \$i is: "${i}" and fib is "${fib}""
            fib_array+=" ${fib}"
    done
}

if [ $# -eq 0 ]
then
    echo "No argument provided. Fist element in fibonacci is 1" 
else 
    fibonnaci
    echo "${fib_array}" | cut -d" " -f $((${1} + 1))
fi
