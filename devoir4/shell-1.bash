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
    for (( i=0; i<10; i++ )); do
	    fib=$(( ${f0} + ${f1}))
	    f0=$f1
	    f1=$fib
	    echo "Value of \$i is: "${i}" and fib is "${fib}""
            fib_array+=" ${fib}"
    done
}
fibonnaci
echo "Content of mem: "${fib_array}""
# Cut is zero-indexed so add one to the field to cut
select_indice="$(\
    echo "${fib_array}" | \
    cut -d" " -f $((${1} + 1)) \
    )"

echo "selected element of fibonnaci_array: "${select_indice}""
