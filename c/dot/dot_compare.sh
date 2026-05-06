#!/bin/bash

i=0
vals[0]=2097152

while [ $i -lt 5 ]
do
    valtmp=${vals[$i]}
    newval=$(echo "$valtmp * 2" | bc)
    i=$((i + 1))
    vals[$i]=$newval
done

unset LC_ALL
export LC_NUMERIC=C

echo "" > dot_compare.dat

for val in "${vals[@]}"
do
    echo "" > data_dot.dat
    echo "" > data_dot_lu.dat
    echo "" > data_cblas.dat

    for i in {1..7}
    do
        ./dot "${val}" 1 off | awk '/^Data/ { print $2 " " $3 }' >> data_dot.dat
        ./dot_lu "${val}" 1 off | awk '/^Data/ { print $2 " " $3 }' >> data_dot_lu.dat
        ~/practica1/cblas/ddot/ddot "${val}" 1 off | awk '/^Data/ { print $2 " " $3 }' >> data_cblas.dat
        echo "${val} ${i} test finished"
    done

    t_dot=$(awk '{sum += $2} END {print sum/7}' data_dot.dat)
    t_dot_lu=$(awk '{sum += $2} END {print sum/7}' data_dot_lu.dat)
    t_cblas=$(awk '{sum += $2} END {print sum/7}' data_cblas.dat)

    echo "${val} ${t_dot} ${t_dot_lu} ${t_cblas}" >> dot_compare.dat
done

awk 'NF > 0' dot_compare.dat
