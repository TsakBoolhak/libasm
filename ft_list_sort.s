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
mov [rsp], r11 ; [rsp] => *begin_list
mov [rsp + 8], r11 ; [rsp + 8] => curr
mov qword[rsp + 16], 0 ; [rsp + 16] => currPrev
mov [rsp + 40], r11 ; [rsp + 40] => toCheckPrev
mov r11, [r11 + 8]
mov [rsp + 24], r11 ; [rsp + 24] => currNext
mov [rsp + 32], r11 ; [rsp + 32] => toCheck
mov r11, [r11 + 8]
mov [rsp + 48], r10; [rsp + 48] => toCheckNext
mov [rsp + 56], rsi ; [rsp + 56] => cmp func

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

.innerLoop:
cmp qword[rsp + 32], 0
je .endOutterLoop
mov r11, [rsp + 32]
mov r11, [r11 + 8]
mov [rsp + 48], r11 ;assign toCheck->next to toCheckNext
mov rdi, [rsp + 8]
mov rdi, [rdi]
mov rsi, [rsp + 32]
mov rsi, [rsi]
mov r10, [rsp + 56]
call r10

mov r11, [rsp + 48]
mov qword[rsp + 32], r11
jmp .innerLoop

.endOutterLoop:
mov r11, [rsp + 8]
mov qword[rsp + 16], r11 ;assign curr to currPrev
mov r11, [rsp + 24]
mov qword[rsp + 8], r11 ; assign curr->next to curr
jmp .outterLoop
.sortEnd:
add rsp, 64 ; deallocating space
.sortRet :
ret