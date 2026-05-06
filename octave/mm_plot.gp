set terminal pngcairo size 1200,700
set output "mm.png"
set title "Multiplicacion matriz-matriz: mm.m vs operador de Octave"
set xlabel "size (n)"
set ylabel "time (seconds)"
set grid
plot "mm.dat" using 1:2 with lines title "mm.m", \
     "mm.dat" using 1:3 with lines title "Octave operador"
