set terminal pngcairo size 900,600 enhanced font "Arial,12"
set output "../informe_latex/img/octave_vs_cblas_mv.png"

set title "Comparación Octave (operador nativo) vs CBLAS — Multiplicación Matriz-Vector"
set xlabel "Tamaño n"
set ylabel "Tiempo promedio (s)"
set key top left
set grid

set logscale x 2
set format x "2^{%L}"

plot "datos/octave_mv.dat" using 1:3 with linespoints \
         lw 2 pt 7 ps 1.2 lc rgb "#0072BD" title "Octave operador", \
     "datos/cblas_dgemv.dat" using 1:2 with linespoints \
         lw 2 pt 5 ps 1.2 lc rgb "#D95319" title "cblas\_dgemv"
