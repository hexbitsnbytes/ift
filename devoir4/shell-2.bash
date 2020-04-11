#!/bin/bash
# iterates over lines of csv file, header removed
for line in $(cat $(pwd)/samples/liste.csv | sed '1d' | tr -d " ");
do
    prefix=`echo $line | cut -d"," -f1,2`
    results=`echo $line | cut -d"," -f 3,4,5,6,7`
    i=0
    # iterates over results for each student
    for (( i=1; i<=5; i++ ))
    do
        echo -n "${prefix},"
        echo $results | cut -d"," -f $i
    done
done