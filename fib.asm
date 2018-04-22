; Assembly Project to calculate the Nth number in fibonacci sequence
; Nick Paladino
.586
.MODEL FLAT
.STACK 4096

.DATA
N DWORD 0			; the Nth number in the sequence (USER INPUT)

; Assuming sequence like this:
; N:	0	1	2	3	4	5
;   	|	|	|	|	|	|
;   	\/	\/	\/	\/	\/	\/
; #:	0	1	1	2	3	5

.CODE
main  PROC

	mov   eax, 0
	cmp   N, 1
	jl    CASE0
	je    CASE1
	mov   ebx, 1

	; While loop
	WS:
	cmp   N, 1
	jl    DONE
	xchg  eax, ebx
	add   eax, ebx
	dec   N
	jmp   WS

	DONE:           ; Answer is in EAX register at this point
	mov   eax, 0    ; Move 0 to eax to terminate with success, overwrites answer
	CASE0:          ; Label to jump to if N == 0
	ret

	CASE1:          ; Label to jump to if N == 1
	mov   eax, 1    ; fib(1) = 1, Answer is in EAX register after this instruction is executed
	jmp   DONE

main  ENDP
END
