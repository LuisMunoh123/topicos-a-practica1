set terminal pngcairo size 1200,700
set output "dgemm.png"
set title "CBLAS dgemm"
set xlabel "size (n)"
set ylabel "time (seconds)"
set grid
plot "dgemm.dat" using 1:2 with lines title "cblas_dgemm"
