%include "bsearch.asm"

section .data
list: dd 1, 3, 5, 7, 10, 12
size: dq 6
find: dd 2

section .text
global _start

_start:
	mov rdi, list
	mov rsi, find
	mov rdx, [size]
	mov rcx, 4
	call bsearch
	; exit(size)
	mov rdi, rax
	mov rax, 0x3c
	syscall
