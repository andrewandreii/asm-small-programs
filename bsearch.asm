%include "memcmp.asm"

bsearch:
	; rdi - void *l
	; rsi - void *find
	; rdx - int nmemb
	; rcx - int size
	push rbp
	mov rbp, rsp

	; 12 bytes (3 * 32bit)
	sub rsp, 0xc

	; lo = 0
	mov DWORD [rbp - 4], 0

	; hi = size
	mov [rbp - 8], edx

	; [rbp - 0xc] = mid
	; not used yet

_bsearch_loop:
	; while(lo <= hi)
	mov eax, [rbp - 4]
	cmp eax, [rbp - 8]
	jg _bsearch_fail

	; mid = (lo + hi) / 2
	mov eax, [rbp - 8]
	add eax, [rbp - 4]
	xor edx, edx
	mov ebx, 2
	div ebx

	; mid = eax
	mov [rbp - 0xc], eax

	; save rdi and rdx
	push rdi
	push rdx
	mul rcx
	lea rdi, [rdi + rax]
	mov rdx, rcx
	call memcmp

	; get the saved registers
	pop rdx
	pop rdi

	; cmp l[mid], find
	cmp rax, 0
	mov eax, [rbp - 0xc]
	je _bsearch_end
	jg _bsearch_greater

_bsearch_lower:
	; lo = mid + 1
	inc rax
	mov [rbp - 4], eax
	jmp _bsearch_loop

_bsearch_greater:
	; hi = mid - 1
	dec rax
	mov [rbp - 8], eax
	jmp _bsearch_loop

_bsearch_fail:
	mov rax, -0x1

_bsearch_end:
	; eax = mid
	add rsp, 0xc
	pop rbp
	ret
