#!/bin/bash

i=0
vals[0]=128

while [ $i -lt 5 ]
do
    valtmp=${vals[$i]}
    newval=$(echo "$valtmp * 2" | bc)
    i=$((i + 1))
    vals[$i]=$newval
done

unset LC_ALL
export LC_NUMERIC=C

echo "" > mm_compare.dat

for val in "${vals[@]}"
do
    echo "" > data_mm.dat
    echo "" > data_mm_opt.dat
    echo "" > data_cblas.dat

    for i in {1..7}
    do
        ./mm "${val}" "${val}" "${val}" 1 off | awk '/^Data/ { print $2 " " $3 }' >> data_mm.dat
        ./mm_opt "${val}" "${val}" "${val}" 1 off | awk '/^Data/ { print $2 " " $3 }' >> data_mm_opt.dat
        ~/practica1/cblas/dgemm/dgemm "${val}" "${val}" "${val}" 1 off | awk '/^Data/ { print $2 " " $3 }' >> data_cblas.dat
        echo "${val} ${i} test finished"
    done

    t_mm=$(awk '{sum += $2} END {print sum/7}' data_mm.dat)
    t_mm_opt=$(awk '{sum += $2} END {print sum/7}' data_mm_opt.dat)
    t_cblas=$(awk '{sum += $2} END {print sum/7}' data_cblas.dat)

    echo "${val} ${t_mm} ${t_mm_opt} ${t_cblas}" >> mm_compare.dat
done

awk 'NF > 0' mm_compare.dat
