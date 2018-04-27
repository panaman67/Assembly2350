extern printf
extern scanf

SECTION .data

	msg:       db "Factorial: %ld", 10, 0

	prompt:    db "What num to be factorialized: ", 0

	sfmt:      db "%d", 0

	menu:      db "0: combonation", 10, "1: permutation", 10, 0

	ans:       dq 0

	playagain: db "Play again: ", 0

	again:     db 'n', 0

	yes:       db 'y', 0

SECTION .text

; THIS FUCKING WORKS!!!!!!!
global main
main:

   menustart:             ; Label for start of loop
	mov  rdi, prompt  ; move the prompt to RDI (1st parameter loc)
	;mov  rsi, 0
	mov  rax, 0       ; needed to disable MMX instructions ?????
	call printf       ; call extern printf proc
	; printf("Enter num: ");
	
	mov  rdi, sfmt    ; move input format to rdi
	mov  rsi, ans     ; move location of ans var to rsi
	mov  rax, 0       ; needed to disable MMX????
	call scanf        ; call scanf
	; scanf("");

	push QWORD [ans]  ; push contents of ans to stack
	call fact         ; call factorial function

	mov  rdi, msg     ; printf stuff for factorial answer
	mov  rsi, rax
	mov  rax, 0
	call printf

	mov  rdi, playagain ; prompt to ask to repeat
	mov  rsi, again
	mov  rax, 0
	call scanf

	; FIXME	
	cmp  BYTE [again], 'y'   ; for checking if we should loop back
	jne  menustart
	mov  eax, 1    ; 1 is code for exit
	int  80h

; Returns factorial of pushed num
fact:
	push rbp
	mov  rbp, rsp

	mov  rax, [rbp + 16]
	cmp  rax, 1
	jle  end

	dec  rax
	push rax
	call fact
	
	mov  rbx, [rbp + 16]
	mul  rbx

     end:
	mov  rsp, rbp
	pop  rbp
	ret
	
	
