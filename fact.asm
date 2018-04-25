extern printf
extern scanf

SECTION .data

	msg:  db "Hello! %d", 10, 0

	menu: db "0: combonation", 10, "1: permutation", 10, 0

	sfmt: db "%c", 0

	ans:  dq 0

SECTION .text

; THIS FUCKING WORKS!!!!!!!
; Prints: Hello! <value returned by fact>
global main
main:
	mov  rdi, menu
	mov  rax, 0
	call printf
	
	;lea    rsi,[rbp-0x1]
	;mov    BYTE PTR [rbp-0x1],0x20
	;mov    al,0x0
	;call   400490 <__isoc99_scanf@plt>
	;movabs rdi,0x400657
	lea  rsi, [ans]
	mov  QWORD [ans], 0x20
	mov  rax, 0
	call scanf

	push QWORD [ans]
	
	call fact
	mov  rsi, rax
	mov  rax, 0
	call printf
	mov  eax, 1    ; 1 is code for exit
	int  80h

; Returns factorial of pushed num
fact:
	push rbp
	mov  rbp, rsp

	mov  rax, [rbp + 16]
	cmp  rax, 1
	je   end

	dec  rax
	push rax
	call fact
	
	mov  rbx, [rbp + 16]
	mul  rbx

  end:
	mov  rsp, rbp
	pop  rbp
	ret
	
	
