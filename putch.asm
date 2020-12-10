putch:
	; dl - char c
	push rbp
	mov rbp, rsp
	sub rsp, 1
	mov BYTE [rbp - 1], dl

	push rax
	push rdi
	push rsi
	push rdx

	mov rax, 1
	mov rdi, 1
	lea rsi, [rbp - 1]
	mov rdx, 1
	syscall

	pop rdx
	pop rsi
	pop rdi
	pop rax

	leave
	ret
