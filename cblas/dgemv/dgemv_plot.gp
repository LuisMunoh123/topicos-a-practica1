set terminal pngcairo size 1200,700
set output "dgemv.png"
set title "CBLAS dgemv"
set xlabel "size (n)"
set ylabel "time (seconds)"
set grid
plot "dgemv.dat" using 1:2 with lines title "cblas_dgemv"
