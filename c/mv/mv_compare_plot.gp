set terminal pngcairo size 1200,700
set output "mv_compare.png"
set title "Algorithms for matrix-vector multiplication"
set xlabel "size (n)"
set ylabel "time (seconds)"
set grid
set key top left
plot "mv_compare.dat" using 1:2 with linespoints lw 2 pt 7 ps 1.0 lc rgb "#0072BD" title "C row major", \
     "mv_compare.dat" using 1:3 with linespoints lw 2 pt 5 ps 1.0 lc rgb "#D95319" title "C column major", \
     "mv_compare.dat" using 1:4 with linespoints lw 2 pt 9 ps 1.0 lc rgb "#77AC30" title "Cblas"
