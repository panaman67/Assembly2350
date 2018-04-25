extern printf
extern scanf

SECTION .data

	msg:  db "Hello! %d", 10, 0

	menu: db "0: combonation", 10, "1: permutation", 0

	sfmt: db "%c", 0

	ans:  dq 4

SECTION .text

; THIS FUCKING WORKS!!!!!!!
; Prints: Hello! <value returned by fact>
global main
main:
	mov  rdi, menu
	mov  rax, 0
	call printf

	; FIXME
	mov  rdi, [ans]
	mov  rsi, sfmt
	call scanf

	push DWORD 6

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
	
	
