#!/bin/bash
# There are several examples relying on bash specific syntax so i'm using /bin/bash as interpreter

# iterates over lines of csv file, header removed
command=$(cat $(pwd)/"${1}" \
          | sed '1d' \
          | tr -d " ")

# Returns all the columns from source file to reuse in output file
studentPrefix() {
    for line in $(cat "$(pwd)/liste.csv" | sed '1d' | tr -d " "); do 
        echo "${line}" 
    done
}

# Returns all the lines from liste.csv source file as elements of listByLine
parsedList() {
    listByLine=()
    # inserts each line as elements of listByLine array
    for line in $command; do 
        listByLine+=$(echo "${line} ")
    done

    echo ${listByLine}
}

# Returns a AVLIST global variable with the list of averages
AVLIST=()
average() {
    # call elements by index: echo ${list[1]}
    list=($(parsedList))
    counter=0
    # Extracts the number of lines from source file to loop over
    loop=4 
    
    #echo "loop=$loop"
    #echo "list: $list"
    for i in $(seq 1 $loop); do
        for line in $(echo "${list[@]}" | cut -f $i -d" "); do
            # Assigns the results to variables
            local f0=$(echo $line | cut -f 3 -d",")
            local f1=$(echo $line | cut -f 4 -d",")
            local f2=$(echo $line | cut -f 5 -d",")
            local f3=$(echo $line | cut -f 6 -d",")
            local f4=$(echo $line | cut -f 7 -d",")
            local f5=$(echo $line | cut -f 8 -d",")
            local f0pond=$(echo "scale=4; $f0 * 0.075" | bc)
            local f1pond=$(echo "scale=4; $f1 * 0.30" | bc)
            local f2pond=$(echo "scale=4; $f2 * 0.075" | bc)
            local f3pond=$(echo "scale=4; $f3 * 0.075" | bc)
            local f4pond=$(echo "scale=4; $f4 * 0.40" | bc)
            local f5pond=$(echo "scale=4; $f5 * 0.075" | bc)
            # Computes the averages
            local op1=$(echo "scale=4; $f0pond + $f1pond + $f2pond + $f3pond + $f4pond + $f5pond" | bc )
            # populates AVLIST env variable for each result
            AVLIST+=("$(echo -n "${op1} ")")
        done
    done
}

# Routine to ouput the studentPrefix with the computed average
count=1
average
echo "$(cat liste.csv | head -n 1),Total" > notes.csv
for student in $(studentPrefix); do
    av=$(echo ${AVLIST[@]} | cut -d" " -f $count)
    echo "${student},${av}" >> notes.csv
    count=$(( count + 1 ))
done