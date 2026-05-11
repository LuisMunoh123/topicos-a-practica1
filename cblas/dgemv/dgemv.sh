#!/bin/bash

i=0
vals[0]=1024

while [ $i -lt 5 ]
do
    valtmp=${vals[$i]}
    newval=$(echo "$valtmp * 2" | bc)
    i=$((i + 1))
    vals[$i]=$newval
done

unset LC_ALL
export LC_NUMERIC=C

echo "" > dgemv.dat

for val in "${vals[@]}"
do
    echo "" > data.dat
    for i in {1..7}
    do
        ./dgemv "${val}" "${val}" 1 off | awk '/^Data/ { print $2 " " $3 }' >> data.dat
        echo "${val} ${i} test finished"
    done
    awk '{n = $1; sum += $2} END {print n, sum/7}' data.dat >> dgemv.dat
done

awk 'NF > 0' dgemv.dat
