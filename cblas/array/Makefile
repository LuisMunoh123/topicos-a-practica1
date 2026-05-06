CC = gcc
FLAGS = -O3 -s -pipe -Wall -fomit-frame-pointer -march=native
ALL = array.o

array.a: ${ALL}
	ar r array.a ${ALL}

array.o: array.c
	${CC} ${FLAGS} -c array.c

clean:
	rm -f core
	rm -f *.o
	rm -f *~
	rm -f *.a
