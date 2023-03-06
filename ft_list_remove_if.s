global ft_list_remove_if
extern free

; void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
; RDI begin_list    RSI data_ref    RDX cmp    RCX free_fct
; avalaible RAX, R8, R9, R10, R11
; R8: keep track of begin list (t_list **)
; R9: prev (t_list *)
; R10: curr (t_list *)
; R11: next (t_list *)
section .text




ft_list_remove_if:
cmp rdi, 0
je .endRemoveIf         ;begin_list is NULL
cmp rdx, 0
je .endRemoveIf         ;cmp function ptr is NULL
mov r8, rdi             ;store begin_list into r8
mov r9, 0               ;set prev to NULL
mov r10, [rdi]          ;set curr to *begin_list

.mainLoop:
cmp r10, 0
je .endRemoveIf         ;parsed whole list
mov r11, [r10 + 8]      ;store curr->next
mov rdi, [r10]          ;set curr->data as first arg

push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
call rdx                ;call cmp function (data_ref is alrdy placed as second arg)
pop r11
pop r10
pop r9
pop r8
pop rcx
pop rdx
pop rsi

cmp rax, 0
jne .noRemove           ;no remove to do
cmp rcx, 0
je .skipFreeFct         ;no free function provided

push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
call rcx                ;call free_fct (curr->data is alrdy placed as first arg)
pop r11
pop r10
pop r9
pop r8
pop rcx
pop rdx
pop rsi

.skipFreeFct:
cmp r9, 0
jne .validPrev          ;there is a valid prev node
mov [r8], r11           ;otherwise we set *begin_list to curr->next
jmp .freeCurr
.validPrev:
mov [r9 + 8], r11       ;we set prev->next to curr->next
.freeCurr:
mov rdi, r10            ;we set curr as first argument

push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
call free wrt ..plt     ;we free curr
pop r11
pop r10
pop r9
pop r8
pop rcx
pop rdx
pop rsi

jmp .lastStep           ;as we freed curr, prev stay untouched
.noRemove:
mov r9, r10             ;no remove were done so we store curr as prev before last step
.lastStep:
mov r10, r11            ;we set curr to curr->next
jmp .mainLoop
.endRemoveIf :
ret