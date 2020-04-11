#!/bin/bash
# There are several examples relying on bash specific syntax so i'm using /bin/bash as interpreter
# iterates over lines of csv file, header removed
set -x 
command=$(cat $(pwd)/samples/liste.csv | sed '1d' | tr -d " ")

parsedList() {
    listByLine=()


    # inserts each line as elements of listByLine array
    for line in $command;
    do 
        listByLine+=$(echo "$line ")
    done

    # Returns all the lines from csv source file as elements of listByLine
    echo $listByLine
}

average() {
    # call elements by index: echo ${list[1]}
    list=($(parsedList))
    #returns the average for each student
    counter=0
    loop=$(cat $(pwd)/samples/liste.csv | sed '1d' | tr -d " " | wc -l)
    for i in $(seq 1 $loop);
    do
        for line in $(echo $list | cut -f $i -d" ");
        do
            f0=$(echo $line | cut -f 3 -d",")
            f1=$(echo $line | cut -f 4 -d",")
            f2=$(echo $line | cut -f 5 -d",")
            f3=$(echo $line | cut -f 6 -d",")
            op1=$(echo $f0 + $f1 + $f2 + $f3 | bc )
            op2=$(echo 4.0 | bc)
            # This does not return the right value yet
            quotient=$(scale=3 && echo $op1 / $op2 | bc)
            remainder=$(scale=3 && echo $op1 % $op2 | bc)
            counter=$(expr $counter + 1)
            echo student $i
            echo quotient: $quotient
            echo remainder: $remainder
        done
    done
}

average