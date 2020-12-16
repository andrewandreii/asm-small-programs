%:
	nasm -g -f elf64 $@_start.asm
	ld $@_start.o

clean:
	rm *.o
