.PHONY: clean run asm

OBJS=main.o fib.a
CFLAGS=-g3

run: fib
		./$<

fib: $(OBJS)
		gcc $(CFLAGS) -o fib $(OBJS)

%.o: %.c
		gcc $(CFLAGS) -c -o $@ $<

%.a: %.o
		ar cr $@ $<

main.c: fib.h
fib.o: fib.c
fib.a: fib.o


clean:
		rm -f fib *.o *a


asm:
		gcc -c -S -o fib.s fib.c
		gcc -c -S -o main.s main.c