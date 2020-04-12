#!/bin/bash
# There are several examples relying on bash specific syntax so i'm using /bin/bash as interpreter
# iterates over lines of csv file, header removed
command=$(cat $(pwd)/samples/liste.csv \
          | sed '1d' \
          | tr -d " ")

# Returns all the columns from source file to reuse in output file
# ACKA16066604,AckouyetWilliam
# ADOA10329606,AdouaAparihouraAngeMack
# AGHS09118409,GauthieEddine
# AITZ30535409,AitMarco
studentPrefix() {
    for line in $command; do 
        echo "${line}" \
        | cut -f 1,2 -d","
    done
}

# Returns all the lines from csv source file as elements of listByLine
#ACKA16066604,AckouyetWilliam,45.5,75,100,95,48.5,90
#ADOA10329606,AdouaAparihouraAngeMack,83,64.75,95,87.5,74,97
#AGHS09118409,GauthieEddine,83,55,95,87.5,41.5,97
#AITZ30535409,AitMarco,69,72,80,67,70,100
parsedList() {
    listByLine=()


    # inserts each line as elements of listByLine array
    for line in $command; do 
        listByLine+=$(echo "${line} ")
    done

    echo ${listByLine}
}

# Returns a AVLIST global variable with the list of averages
# echo $AVLIST     
# 78.875  82.562  80.125  72.000
AVLIST=()
average() {
    # call elements by index: echo ${list[1]}
    list=($(parsedList))
    counter=0
    # Extracts the number of lines from source file to loop over
    loop=$(cat $(pwd)/samples/liste.csv \
           | sed '1d' \
           | tr -d " " \
           | wc -l)
    # Accounts for the last line that does not have a new line character. `wc -l` 
    # only counts the number of newlines "\n"
    loop=$(( ${loop} + 1 ))
    
    for i in $(seq 1 $loop); do
        for line in $(echo ${list[@]} | cut -f $i -d" "); do
            # Assigns the results to variables
            local f0=$(echo $line | cut -f 3 -d",")
            local f1=$(echo $line | cut -f 4 -d",")
            local f2=$(echo $line | cut -f 5 -d",")
            local f3=$(echo $line | cut -f 6 -d",")
            local op1=$(echo $f0 + $f1 + $f2 + $f3 | bc )
            local op2=$(echo 4.0 | bc)
            # Computes the averages
            local quotient=$(echo "scale=3; ${op1} / ${op2}" | bc)
            local remainder=$(echo "scale=3; ${op1} % ${op2}" | bc)
            counter=$(( ${counter} + 1))
            AVLIST+="$(echo -n "${quotient} ")"
        done
    done
}
average

# Routine to ouput the studentPrefix with the computed average
i=1
for student in $(studentPrefix); do
    echo "${student},$(echo $AVLIST[${i}] | cut -f ${i} -d" ")"
    i=$(( ${i} + 1 ))
done