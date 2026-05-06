set terminal pngcairo size 1200,700
set output "ddot.png"
set title "CBLAS ddot"
set xlabel "size (n)"
set ylabel "time (seconds)"
set grid
plot "ddot.dat" using 1:2 with lines title "cblas_ddot"
