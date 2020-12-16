%include "memcmp.asm"

section .data
list_a: db 1, 2, 4, 4, 6
list_b: db 1, 2, 3, 4, 5
list_c: db 1, 2, 3, 3, 4
size: dq 5

section .text
global _start

print_res:
	push rbp
	mov rbp, rsp

	push rdi
	push rsi
	push rdx

	; move return value to stack
	mov [rbp - 1], al

	; syscall write
	mov rax, 1

	; we print to stdout
	mov rdi, 1

	; we print just 1 char each time
	mov rdx, 1

	; see if you need to print the minus or not
	cmp BYTE [rbp - 1], 0
	jge _print_res_skip_minus

	; write minus
	mov rax, 1
	mov BYTE [rbp - 2], "-"
	lea rsi, [rbp - 2]
	syscall

	; change return value from -1 to 1
	mov BYTE [rbp - 1], 1

_print_res_skip_minus:
	mov rax, 1

	; write the number
	add BYTE [rbp - 1], "0"
	lea rsi, [rbp - 1]
	syscall

	; write newline
	mov BYTE [rbp - 1], 10
	syscall
	pop rdx
	pop rsi
	pop rdi
	pop rbp
	ret

_start:
	; smaller
	mov rdi, list_c
	mov rsi, list_b
	mov rdx, [size]
	call memcmp
	call print_res

	; greater
	mov rdi, list_a
	call memcmp
	call print_res

	; equal
	mov rdi, list_b
	call memcmp
	call print_res

	; exit(last_return)
	mov rdi, rax
	mov rax, 0x3c
	syscall
