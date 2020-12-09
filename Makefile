%:
	nasm -f elf64 $@_start.asm
	ld -o $@ $@_start.o
