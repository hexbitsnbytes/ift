#!/bin/bash
# From Fibonacci Iterative Algorithm
f0=0
f1=1
arg=$1
# Returns an element of fibonnaci based on index
fib_array=(1)
fibonnaci() {
    for (( i=0; i<10; i++ ))
    do
	    fib=$(expr $f0 + $f1)
	    f0=$f1
	    f1=$fib
	    echo "Value of \$i is: $i" " and fib is $fib"
            fib_array+=" $fib"
    done
}
fibonnaci
echo "Content of mem: $fib_array"
select_indice=$(echo $fib_array | cut -d" " -f `expr $1 + 1`)

echo "selected element of fibonnaci_array: $select_indice"
