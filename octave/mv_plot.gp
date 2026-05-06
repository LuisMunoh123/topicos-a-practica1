set terminal pngcairo size 1200,700
set output "mv.png"
set title "Multiplicacion matriz-vector: mv.m vs operador de Octave"
set xlabel "size (n)"
set ylabel "time (seconds)"
set grid
plot "mv.dat" using 1:2 with lines title "mv.m", \
     "mv.dat" using 1:3 with lines title "Octave operador"
