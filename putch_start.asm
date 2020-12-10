%include "putch.asm"

section .text
global _start

_start:
	mov dl, "!"
	call putch

	mov rax, 0x3c
	syscall
