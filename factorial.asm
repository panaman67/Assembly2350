

main	PROC

	push	ebp
	mov	ebp, esp
	

	leave
	exit

main	ENDP



fact	PROC

	push	ebp		; Create stack frame
	mov,	ebp, esp	; move ebp to esp
	cmp 	[ebp + 8], 1	; Compare first arg to 1
	jle	base		; If less than or equal to 1, is base case
	mov	eax, [ebp + 8]	; If not, move arg to eax
	dec	eax		; Decrement eax
	push	eax		; Push new value to stack
	call	fact		; Call fact again recursivly
 base:  mov	eax, 1		; Base case, move 1 to eax
	pop	ebp		; Restore old base pointer???
	ret 			; Return from function

fact	ENDP
