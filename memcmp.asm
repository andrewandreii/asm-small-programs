; memcmp(void *a, void *b, int size) -> rax
; - uses rcx (saves to the stack)
; - returns rax (-1, 0, 1)
; - doesnt use stack for local variables

memcmp:
	; rdi - void *a
	; rsi - void *b
	; rdx - int size
	; rax - return
	; rcx - counter
	push rbp
	mov rbp, rsp
	push rcx

	xor rcx, rcx

_memcmp_loop:
	cmp rcx, rdx

	je _memcmp_equal

	mov al, [rdi + rcx]
	cmp al, [rsi + rcx]

	jl _memcmp_lower
	jg _memcmp_greater

	inc rcx
	jmp _memcmp_loop

_memcmp_lower:
	mov rax, -0x1
	jmp _memcmp_end

_memcmp_greater:
	mov rax, 1
	jmp _memcmp_end

_memcmp_equal:
	xor rax, rax

_memcmp_end:
	pop rcx
	pop rbp
	ret
