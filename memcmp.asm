; memcmp(void *a, void *b, int size);
; - uses rcx (saves to the stack)
; - returns rax {-1, 0, 1}
; - doesnt use stack for local variables

memcmp:
	; rdi - void *a
	; rsi - void *b
	; rdx - int size
	; rcx - loop counter
	; rax - return
	push rcx

	; loop_counter = 0
	xor rcx, rcx

_memcmp_start:
	; while loop_counter <= size
	cmp rcx, rdx

	; exit while
	jg _memcmp_equal

	; cmp a[loop_counter], b[loop_counter]
	mov al, [rsi + rcx]
	cmp BYTE [rdi + rcx], al

	jg _memcmp_greater
	jl _memcmp_lower

	; ++ loop_counter;
	inc rcx

	jmp _memcmp_start

_memcmp_lower:
	; return = -1
	mov rax, -1
	jmp _memcmp_end

_memcmp_greater:
	; return = 1
	mov rax, 1
	jmp _memcmp_end

_memcmp_equal:
	xor rax, rax

_memcmp_end:
	pop rcx
	ret
