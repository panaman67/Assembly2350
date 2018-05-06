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

	menu:      db  "0: combonation", 10, "1: permutation", 10, 0
	prompt:    db  "What num to be factorialized: ", 0
	playagain: db  "Play again: ", 0
	factfmt:   db  "%d", 0
	againfmt:  db  "%s", 0
	testfmt:   db  "You entered: %s", 10, 0
	ans:       dq  0
	ans2:      dq  0
	again:     db  "", 0
	msg:       db  "Factorial: %ld", 10, 0
	yesString: db  "yes", 0

SECTION .bss
	againAnswer: RESB 255

SECTION .text

global main
main:

   menustart:              ; Label for start of loop
	mov   rdi, prompt  ; move the prompt to RDI (1st parameter loc)
	mov   rsi, 0
	mov   rax, 0       ; needed to disable MMX instructions ?????
	call  printf       ; call extern printf proc
	; printf("Enter num: ");
	
	mov   rdi, factfmt ; move input format to rdi
	mov   rsi, ans     ; move location of ans var to rsi
	mov   rax, 0       ; needed to disable MMX????
	call  scanf        ; call scanf
	; scanf("%d", &ans);
;-------------------------------------------------------------------------------
	mov   rdi, prompt  ; move the prompt to RDI (1st parameter loc)
	mov   rsi, 0
	mov   rax, 0       ; needed to disable MMX instructions ?????
	call  printf       ; call extern printf proc
	; printf("Enter num: ");
	
	mov   rdi, factfmt ; move input format to rdi
	mov   rsi, ans2     ; move location of ans var to rsi
	mov   rax, 0       ; needed to disable MMX????
	call  scanf        ; call scanf
	; scanf("%d", &ans);
;----------------------------------------------------------------------------------
	push  QWORD [ans2]  ; push contents of ans to stack
	push  QWORD [ans]
	call  combo         ; call factorial function

	mov   rdi, msg     ; printf stuff for factorial answer
	mov   rsi, rax
	mov   rax, 0
	call  printf
	; printf("Factorial: %d\n", rax /* fact(ans)*/);

	mov   rdi, playagain
	mov   rax, 0
	call  printf
	; printf("Play again: ");

	mov   rdi, againfmt ; prompt to ask to repeat
	mov   rsi, again
	mov   rax, 0
	call  scanf
	; scanf("%c", &again);

	; compare string code
	lea   rsi, [again]
	lea   rdi, [yesString]
	mov   rcx, 4
	rep   cmpsb
	mov   rax, 4
	mov   rbx, 1
	jne   out
	
    stringsMatch:
	jmp menustart

    out:
	mov   eax, 1    ; 1 is code for exit
	int   0x80

; Returns factorial of pushed num
fact:
	push  rbp
	mov   rbp, rsp

	mov   rax, [rbp + 16]
	cmp   rax, 1
	jle   end

	dec   rax
	push  rax
	call  fact
	
	mov   rbx, [rbp + 16]
	mul   rbx

     end:
	mov   rsp, rbp
	pop   rbp
	ret

combo:
	push rbp
	mov  rbp, rsp        ; Stack frame

	mov  rdx, [rbp + 16] ; n
	mov  rcx, [rbp + 24] ; r
	push rdx             ; push n
	call fact            ; call func
	mov  r15, rax        ; move n! to rdx
	
	push rcx
	call fact
;-------------BEFORE THIS WORKS------------------------------------
	mov  r12, rax         ; move r! to r12

	sub  rdx, rcx         ; (n-r)
	mov  rax, rdx     ; TEMPORARY!!!!!
;-------^^^^^^^^^^^^^---------- DOESNT WORK!!!!! eg saying 5-2 = 0
;       N (rdx) is getting erased by this point....
;
;	push rbx
;	call fact
;	mov  r13, rax        ; move (n-r)! to r10
;
;	mov  rax, r12         ; move r! to rax
;	mul  r13             ; r!(n-r)! to rax
;	mov  r14, rax        ; move above to r11
;	mov  rax, r12         ; move r! to rax
;	div  r14             ; do division, result is in rax
	mov  rsp, rbp
	pop  rbp
	ret
	
	
