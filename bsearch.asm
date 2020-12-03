section .data
list: dd 1, 3, 5, 7, 10, 12
size: dd 6
find: dd 7

section .text
global _start

_start:
	mov rbp, rsp
	; 8 bytes, 2 dword values
	sub rsp, 8

	; hi = size
	mov eax, [size]
	mov [rbp - 4], eax

	; lo = 0
	mov DWORD [rbp - 8], 0

_loop_start:
	mov eax, [rbp - 4]
	cmp eax, [rbp - 8]
	jl _return

	; mid = (lo + hi) / 2
	add eax, [rbp - 8]
	xor edx, edx
	mov ebx, 2
	div ebx

	; cmp mid, find
	mov ebx, [find]
	cmp [list + eax * 4], ebx

	je _if_eq
	jl _if_greater

_if_lower:
	; hi = mid - 1
	dec eax
	mov [rbp - 4], eax
	jmp _loop_start

_if_greater:
	; lo = mid + 1
	inc eax
	mov [rbp - 8], eax
	jmp _loop_start

_if_eq:
	; exit(mid)
	mov ebx, eax
	mov eax, 1
	int 0x80

_return:
	; cannot find the value
	; exit(size)
	mov eax, 1
	mov ebx, [size]
	int 0x80
