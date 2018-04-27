extern printf
extern scanf

SECTION .data

	menu:      db  "0: combonation", 10, "1: permutation", 10, 0
	prompt:    db  "What num to be factorialized: ", 0
	playagain: db  "Play again: ", 0
	sfmt:      db  "%d", 0
	againfmt:  db  "%d", 0
	testfmt    db  "You entered: %c",10, 0
	ans:       dq  0
	again:     db  ' ', 0 ; 121 = 'y'
	msg:       db  "Factorial: %ld", 10, 0

SECTION .text

global main
main:

   menustart:             ; Label for start of loop
	mov  rdi, prompt  ; move the prompt to RDI (1st parameter loc)
	mov  rax, 0       ; needed to disable MMX instructions ?????
	call printf       ; call extern printf proc
	; printf("Enter num: ");
	
	mov  rdi, sfmt    ; move input format to rdi
	mov  rsi, ans     ; move location of ans var to rsi
	mov  rax, 0       ; needed to disable MMX????
	call scanf        ; call scanf
	; scanf("%d", &ans);

	push QWORD [ans]  ; push contents of ans to stack
	call fact         ; call factorial function

	mov  rdi, msg     ; printf stuff for factorial answer
	mov  rsi, rax
	mov  rax, 0
	call printf
	; printf("Factorial: %d\n", rax /* fact(ans)*/);
	mov  rdi, 0

	mov  rdi, playagain
	mov  rax, 0
	call printf
	; printf("Play again: ");

	mov  rdi, againfmt ; prompt to ask to repeat
	mov  rsi, again
	mov  rax, 0
	call scanf
	; scanf("%c", &again);


	mov  rdi, testfmt
	mov  rbx, again
	mov  rsi, rbx
	mov  rax, 0
	call printf





	; FIXME: This works with format %d and cmp with ascii code values,
	;        but not with %c and character literals :(
	;cmp  BYTE [again], BYTE 121   ; for checking if we should loop back
	;je   menustart
	mov  eax, 1    ; 1 is code for exit
	int  0x80

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
