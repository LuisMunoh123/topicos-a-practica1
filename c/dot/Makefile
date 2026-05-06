CC = gcc
FLAGS = -O3 -s -pipe -Wall -fomit-frame-pointer -march=native -I../../cblas/array -w
LIBRARY = ../../cblas/array/array.a

all: dot dot_lu

dot: dot.c
	${CC} ${FLAGS} -c dot.c
	${CC} ${FLAGS} -o dot dot.o ${LIBRARY}

dot_lu: dot_lu.c
	${CC} ${FLAGS} -c dot_lu.c
	${CC} ${FLAGS} -o dot_lu dot_lu.o ${LIBRARY}

clean:
	rm -f core
	rm -f *.o
	rm -f *~
	rm -f dot
	rm -f dot_lu
