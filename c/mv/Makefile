CC = gcc
FLAGS = -O3 -s -pipe -Wall -fomit-frame-pointer -march=native -I../../cblas/array -w
LIBRARY = ../../cblas/array/array.a

all: mv mv_lu

mv: mv.c
	${CC} ${FLAGS} -c mv.c
	${CC} ${FLAGS} -o mv mv.o ${LIBRARY}

mv_lu: mv_lu.c
	${CC} ${FLAGS} -c mv_lu.c
	${CC} ${FLAGS} -o mv_lu mv_lu.o ${LIBRARY}

clean:
	rm -f core
	rm -f *.o
	rm -f *~
	rm -f mv
	rm -f mv_lu
