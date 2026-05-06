set terminal pngcairo size 1200,700
set output "dot_compare.png"
set title "Producto punto en C: dot vs dot_lu vs cblas_ddot"
set xlabel "size (n)"
set ylabel "time (seconds)"
set grid
plot "dot_compare.dat" using 1:2 with lines title "dot", \
     "dot_compare.dat" using 1:3 with lines title "dot_lu", \
     "dot_compare.dat" using 1:4 with lines title "cblas_ddot"
