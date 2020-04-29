#!/bin/bash
# There are several examples relying on bash specific syntax so i'm using /bin/bash as interpreter
# iterates over lines of csv file, header removed
command=$(cat $(pwd)/"${1}" \
          | sed '1d' \
          | tr -d " ")

# Returns all the columns from source file to reuse in output file
# ACKA16066604,AckouyetWilliam
# ADOA10329606,AdouaAparihouraAngeMack
# AGHS09118409,GauthieEddine
# AITZ30535409,AitMarco
studentPrefix() {
    for line in $(cat "$(pwd)/liste.csv" | sed '1d' | tr -d " "); do 
        echo "${line}" #\
        #| cut -f 1,2 -d","
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
# echo $AVLIST     
# 78.875  82.562  80.125  72.000
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
            #echo "f0=$f0"
            #echo "f1=$f1"
            #echo "f2=$f2"
            #echo "f3=$f3"
            #echo "f4=$f4"
            #echo "f5=$f5"
            local op1=$(echo "scale=4; $f0pond + $f1pond + $f2pond + $f3pond + $f4pond + $f5pond" | bc )
            # Computes the averages
            #counter=$(( counter + 1))
            AVLIST+=("$(echo -n "${op1} ")")
        done
    done
}

# Routine to ouput the studentPrefix with the computed average
count=1
average
echo "$(cat liste.csv | head -n 1),Total" > notes.csv
for student in $(studentPrefix); do
    #echo "count=$count"
    #echo "AVLIST:${AVLIST[@]}"
    av=$(echo ${AVLIST[@]} | cut -d" " -f $count)
    #echo "av=$av"
    echo "${student},${av}" >> notes.csv
    count=$(( count + 1 ))
done