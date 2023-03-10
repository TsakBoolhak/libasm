global ft_list_sort

;void ft_list_sort(t_list **begin_list, int (*cmp)())
;*begin_list, curr, currPrev, currNext, toCheck, toCheckPrev, toCheckNext 

ft_list_sort:
cmp rdi, 0 ; begin_list is NULL
je .sortRet
cmp qword[rdi], 0 ; *begin_list is NULL
je .sortRet
cmp qword[rdi + 8], 0 ; list only has 1 element, no need to sort
je .sortRet
.init:
sub rsp, 64 ; allocating spaces for 7 pointers
mov r11, [rdi]
mov [rsp], rdi ; [rsp] => begin_list
mov [rsp + 8], r11 ; [rsp + 8] => curr
mov qword[rsp + 16], 0 ; [rsp + 16] => currPrev
mov [rsp + 40], r11 ; [rsp + 40] => toCheckPrev
mov r11, [r11 + 8]
mov [rsp + 24], r11 ; [rsp + 24] => currNext
mov [rsp + 32], r11 ; [rsp + 32] => toCheck
mov r11, [r11 + 8]
mov [rsp + 48], r11; [rsp + 48] => toCheckNext
mov [rsp + 56], rsi ; [rsp + 56] => cmp func

mov rdi, [rsp + 8] ;rdi curr ; [rsp + 8] => curr (BECOME toCheck)
mov rsi, [rsp + 24] ;rsi currNext ; [rsp + 24] => currNext
mov rdx, [rsp + 16] ;rdx currPrev ;  [rsp + 16] => currPrev
mov r9, [rsp + 32] ;r9 toCheck ; [rsp + 32] => toCheck   (BECOME curr)
mov r10, [rsp + 48] ;r10 toCheckNext ; [rsp + 48] => toCheckNext 
mov r11, [rsp + 40] ;r11 toCheckPrev ; [rsp + 40] => toCheckPrev


.outterLoop:
cmp qword[rsp + 8], 0 ;curr == NULL
je .sortEnd

mov r11, [rsp + 8]
mov qword[rsp + 40], r11 ; assign curr to toCheckPrev
mov r11, [r11 + 8]
mov qword[rsp + 24], r11  ; set currNext

cmp r11, 0
je .sortEnd
mov qword[rsp + 32], r11 ; assign curr->next to toCheck

mov rdi, [rsp + 8] ;rdi curr ; [rsp + 8] => curr
mov rsi, [rsp + 24] ;rsi currNext ; [rsp + 24] => currNext
mov rdx, [rsp + 16] ;rdx currPrev ;  [rsp + 16] => currPrev
mov r9, [rsp + 32] ;r9 toCheck ; [rsp + 32] => toCheck
mov r10, [rsp + 48] ;r10 toCheckNext ; [rsp + 48] => toCheckNext
mov r11, [rsp + 40] ;r11 toCheckPrev ; [rsp + 40] => toCheckPrev

.innerLoop:
cmp qword[rsp + 32], 0
je .endOutterLoop
;je .outterLoop
mov r11, [rsp + 32]
mov r11, [r11 + 8]
mov [rsp + 48], r11 ;assign toCheck->next to toCheckNext
mov r11, [rsp + 8]
mov rdi, [r11]
mov r11, [rsp + 32]
mov rsi, [r11]
.a: mov r10, [rsp + 56]
call r10
.b: cmp eax, 0
jle .skipSwap

mov rdi, [rsp + 8] ;rdi curr ; [rsp + 8] => curr
mov rsi, [rsp + 24] ;rsi currNext ; [rsp + 24] => currNext
mov rdx, [rsp + 16] ;rdx currPrev ;  [rsp + 16] => currPrev
mov r9, [rsp + 32] ;r9 toCheck ; [rsp + 32] => toCheck
mov r10, [rsp + 48] ;r10 toCheckNext ; [rsp + 48] => toCheckNext
mov r11, [rsp + 40] ;r11 toCheckPrev ; [rsp + 40] => toCheckPrev

.swap:

cmp rdx, 0
jne .validPrev
mov r8, [rsp] ;begin_list
mov [r8], r9 ;assign toCheck to *begin_list
jmp .nextStep
.validPrev:
mov qword[rdx + 8], r9 ; CurP->next = swap
.nextStep:
mov [r11 + 8], rdi
mov [r9 + 8], rsi
mov [rdi + 8], r10

cmp r11, rdi
jne .otherStep

mov [rsi + 8], rdi

.otherStep:
mov qword[rsp + 8], r9 ; update rsp + 8 (new curr)
mov r8, [r9 + 8]
mov qword[rsp + 24], r8
mov qword[rsp + 32], rdi ; update rsp + 32 (new toCheck)

mov rdi, [rsp + 8] ;rdi curr ; [rsp + 8] => curr
mov rsi, [rsp + 24] ;rsi currNext ; [rsp + 24] => currNext
mov rdx, [rsp + 16] ;rdx currPrev ;  [rsp + 16] => currPrev
mov r9, [rsp + 32] ;r9 toCheck ; [rsp + 32] => toCheck
mov r10, [rsp + 48] ;r10 toCheckNext ; [rsp + 48] => toCheckNext
mov r11, [rsp + 40] ;r11 toCheckPrev ; [rsp + 40] => toCheckPrev

.skipSwap:
mov r11, [rsp + 32]
mov qword[rsp + 40], r11
mov r11, [r11 + 8]
mov qword[rsp + 32], r11
jmp .innerLoop

mov rdi, [rsp + 8] ;rdi curr ; [rsp + 8] => curr
mov rsi, [rsp + 24] ;rsi currNext ; [rsp + 24] => currNext
mov rdx, [rsp + 16] ;rdx currPrev ;  [rsp + 16] => currPrev
mov r9, [rsp + 32] ;r9 toCheck ; [rsp + 32] => toCheck
mov r10, [rsp + 48] ;r10 toCheckNext ; [rsp + 48] => toCheckNext
mov r11, [rsp + 40] ;r11 toCheckPrev ; [rsp + 40] => toCheckPrev

.endOutterLoop:
mov r11, [rsp + 8]
mov qword[rsp + 16], r11 ;assign curr to currPrev
mov r10, [r11 + 8]
mov qword[rsp + 8], r10 ; assign curr->next to curr
.bpoint:

mov rdi, [rsp + 8] ;rdi curr ; [rsp + 8] => curr
mov rsi, [rsp + 24] ;rsi currNext ; [rsp + 24] => currNext
mov rdx, [rsp + 16] ;rdx currPrev ;  [rsp + 16] => currPrev
mov r9, [rsp + 32] ;r9 toCheck ; [rsp + 32] => toCheck
mov r10, [rsp + 48] ;r10 toCheckNext ; [rsp + 48] => toCheckNext
mov r11, [rsp + 40] ;r11 toCheckPrev ; [rsp + 40] => toCheckPrev

jmp .outterLoop

mov rdi, [rsp + 8] ;rdi curr ; [rsp + 8] => curr
mov rsi, [rsp + 24] ;rsi currNext ; [rsp + 24] => currNext
mov rdx, [rsp + 16] ;rdx currPrev ;  [rsp + 16] => currPrev
mov r9, [rsp + 32] ;r9 toCheck ; [rsp + 32] => toCheck
mov r10, [rsp + 48] ;r10 toCheckNext ; [rsp + 48] => toCheckNext
mov r11, [rsp + 40] ;r11 toCheckPrev ; [rsp + 40] => toCheckPrev

.sortEnd:
add rsp, 64 ; deallocating space
.sortRet :
ret