CC = gcc
FLAGS = -O3 -s -pipe -Wall -fomit-frame-pointer -march=native -I../../cblas/array -w
LIBRARY = ../../cblas/array/array.a

all: mm mm_opt

mm: mm.c
	${CC} ${FLAGS} -c mm.c
	${CC} ${FLAGS} -o mm mm.o ${LIBRARY}

mm_opt: mm_opt.c
	${CC} ${FLAGS} -c mm_opt.c
	${CC} ${FLAGS} -o mm_opt mm_opt.o ${LIBRARY}

clean:
	rm -f core
	rm -f *.o
	rm -f *~
	rm -f mm
	rm -f mm_opt
