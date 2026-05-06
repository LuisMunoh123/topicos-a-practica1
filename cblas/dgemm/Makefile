CC = gcc
FLAGS = -O3 -s -pipe -Wall -fomit-frame-pointer -march=native -I../array -w
LIBRARY = ../array/array.a
EXEC = dgemm

all: ${EXEC}

${EXEC}: ${EXEC}.c
	${CC} ${FLAGS} -c ${EXEC}.c
	${CC} ${FLAGS} -o ${EXEC} ${EXEC}.o ${LIBRARY} -lblas

clean:
	rm -f core
	rm -f *.o
	rm -f *~
	rm -f ${EXEC}
