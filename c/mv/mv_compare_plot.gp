set terminal pngcairo size 1200,700
set output "mv_compare.png"
set title "Matriz-vector en C: mv vs mv_lu vs cblas_dgemv"
set xlabel "size (n)"
set ylabel "time (seconds)"
set grid
plot "mv_compare.dat" using 1:2 with lines title "mv", \
     "mv_compare.dat" using 1:3 with lines title "mv_lu", \
     "mv_compare.dat" using 1:4 with lines title "cblas_dgemv"
