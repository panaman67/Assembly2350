;Create an assembly program that will calculate a user's choice of either combination orpermutation.
; -Your main procedure will print a menu for the user and read their input.
;      factorial, combination and permutation.
; -Factorial should be a recursively defined procedure that takes an integer argument
;      (passed on the stack) and returns it's factorial.
; -The combination and permutation procedures will use the factorial procedure
;      that you create in order to perform their calculations.
; -After each selection the user should be asked if they would like to perform another operation.
; -If they enter "yes" (not just 'y') they should be able to continue.
; -Otherwise, the program should exit


extern printf
extern scanf

SECTION .data

	;menu:      db  "0: combonation", 10, "1: permutation", 10, 0
	prompt:    db  "What num to be factorialized: ", 0
	playagain: db  "Play again: ", 0
	factfmt:   db  "%d", 0
	againfmt:  db  "%s", 0
	testfmt    db  "You entered: %s", 10, 0
	ans:       dq  0
	again:     db  ' ', 0
	msg:       db  "Factorial: %ld", 10, 0

SECTION .text

global main
main:

   menustart:             ; Label for start of loop
	mov  rdi, prompt  ; move the prompt to RDI (1st parameter loc)
	mov  rax, 0       ; needed to disable MMX instructions ?????
	call printf       ; call extern printf proc
	; printf("Enter num: ");
	
	mov  rdi, factfmt ; move input format to rdi
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
	mov  rsi, again
	mov  rax, 0
	call printf
	; printf("You entered: %c\n", again);


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
