#!/bin/bash
# There are several examples relying on bash specific syntax so i'm using /bin/bash as interpreter
# iterates over lines of csv file, header removed
command=$(cat $(pwd)/samples/liste.csv \
          | sed '1d' \
          | tr -d " ")

# Returns all the lines from csv source file as elements of listByLine
studentPrefix() {
    for line in $command; do 
        echo "${line}" \
        | cut -f 1,2 -d","
    done
}
# Returns all the lines from csv source file as elements of listByLine
parsedList() {
    listByLine=()


    # inserts each line as elements of listByLine array
    for line in $command; do 
        listByLine+=$(echo "${line} ")
    done

    echo ${listByLine}
}

# Returns a global variable with the list of averages
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
            f0=$(echo $line | cut -f 3 -d",")
            f1=$(echo $line | cut -f 4 -d",")
            f2=$(echo $line | cut -f 5 -d",")
            f3=$(echo $line | cut -f 6 -d",")
            op1=$(echo $f0 + $f1 + $f2 + $f3 | bc )
            op2=$(echo 4.0 | bc)
            # This does not return the right value yet
            quotient=$(echo "scale=3; ${op1} / ${op2}" | bc)
            remainder=$(echo "scale=3; ${op1} % ${op2}" | bc)
            counter=$(( ${counter} + 1))
            #echo student $i
            #echo -n "${quotient} "
            AVLIST+="$(echo -n "${quotient} ")"
            #echo remainder: $remainder
        done
    done
}
average


i=1
for student in $(studentPrefix); do
    echo ${student}, $(echo $AVLIST[${i}] | cut -f ${i} -d" ")
    i=$(( ${i} + 1 ))
done