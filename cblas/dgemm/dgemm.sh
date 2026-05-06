#!/bin/bash

i=0
vals[0]=8

while [ $i -lt 9 ]
do
    valtmp=${vals[$i]}
    newval=$(echo "$valtmp * 2" | bc)
    i=$((i + 1))
    vals[$i]=$newval
done

unset LC_ALL
export LC_NUMERIC=C

echo "" > dgemm.dat

for val in "${vals[@]}"
do
    echo "" > data.dat
    for i in {1..7}
    do
        ./dgemm "${val}" "${val}" "${val}" 1 off | awk '/^Data/ { print $2 " " $3 }' >> data.dat
        echo "${val} ${i} test finished"
    done
    awk '{n = $1; sum += $2} END {print n, sum/7}' data.dat >> dgemm.dat
done

awk 'NF > 0' dgemm.dat
