set terminal pngcairo size 1200,700
set output "dot.png"
set title "Producto punto: dot.m vs operador de Octave"
set xlabel "size (n)"
set ylabel "time (seconds)"
set grid
plot "dot.dat" using 1:2 with lines title "dot.m", \
     "dot.dat" using 1:3 with lines title "Octave operador"
