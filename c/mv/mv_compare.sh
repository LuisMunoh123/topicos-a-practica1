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

echo "" > mv_compare.dat

for val in "${vals[@]}"
do
    echo "" > data_mv.dat
    echo "" > data_mv_lu.dat
    echo "" > data_cblas.dat

    for i in {1..7}
    do
        ./mv "${val}" "${val}" 1 off | awk '/^Data/ { print $2 " " $3 }' >> data_mv.dat
        ./mv_lu "${val}" "${val}" 1 off | awk '/^Data/ { print $2 " " $3 }' >> data_mv_lu.dat
        ~/practica1/cblas/dgemv/dgemv "${val}" "${val}" 1 off | awk '/^Data/ { print $2 " " $3 }' >> data_cblas.dat
        echo "${val} ${i} test finished"
    done

    t_mv=$(awk '{sum += $2} END {print sum/7}' data_mv.dat)
    t_mv_lu=$(awk '{sum += $2} END {print sum/7}' data_mv_lu.dat)
    t_cblas=$(awk '{sum += $2} END {print sum/7}' data_cblas.dat)

    echo "${val} ${t_mv} ${t_mv_lu} ${t_cblas}" >> mv_compare.dat
done

awk 'NF > 0' mv_compare.dat
