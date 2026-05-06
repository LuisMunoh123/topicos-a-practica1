set terminal pngcairo size 1200,700
set output "mm_compare.png"
set title "Matriz-matriz en C: mm vs mm_opt vs cblas_dgemm"
set xlabel "size (n)"
set ylabel "time (seconds)"
set grid
plot "mm_compare.dat" using 1:2 with lines title "mm", \
     "mm_compare.dat" using 1:3 with lines title "mm_opt", \
     "mm_compare.dat" using 1:4 with lines title "cblas_dgemm"
