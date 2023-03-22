            global ft_list_remove_if
            ;void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
            ;rdi => begin_list    rsi => data_ref    rdx => cmp    rcx => free_fct

            ;typedef struct  s_list
            ;{
            ;   void            *data;
            ;   struct s_list   *next;
            ;}

            extern free

            section .text

    ft_list_remove_if:
.initRemoveIf:
            sub rsp,    56                      ;allocate enough space for 7 pointers (and align stack)
            cmp rdi,    0                       ;check if begin_list is NULL
            je  .endRemoveIf                    ;if so we do nothing
            cmp rdx,    0                       ;check if compare function is NULL
            je  .endRemoveIf                    ;if so we do nothing
            mov qword[rsp], rdi                 ;[rsp] => begin_list
            mov qword[rsp + 8], rsi             ;[rsp + 8] => data_ref
            mov qword[rsp + 16],    rdx         ;[rsp + 16] => compare function
            mov qword[rsp + 24],    rcx         ;[rsp + 24] => free function
            mov qword[rsp + 32],    0           ;[rsp + 32] => prev node
            mov r8, [rdi]                       ;we stor *begin_list in a register to do the next instruction
            mov qword[rsp + 40],    r8          ;[rsp + 40] => current node (start at *begin_list)

.mainLoop:
            cmp qword[rsp + 40],    0           ;check if current node is NULL
            je  .endRemoveIf                    ;if so that means we parsed whole list
            mov r8, [rsp + 40]                  ;store current into r8
            mov rdi,    [r8]                    ;set curr->data as first arg
            mov r8, [r8 + 8]                    ;to store curr->next into r8 for the next instruction
            mov qword[rsp + 48],    r8          ;[rsp + 48] => curr->next
            mov rsi,    [rsp + 8]               ;set data_ref as second argument
            call    qword[rsp + 16]             ;call cmp function
            cmp rax,    0                       ;check the return of compare function
            jne .noRemove                       ;if it returns a non zero value the node is not to be removed
            cmp qword[rsp + 24],    0           ;check if a free function were provided to handle the node's data
            je  .skipFreeFct                    ;no free function were provided so we don't handle the data
            mov r8, [rsp + 40]                  ;store current into r8
            mov rdi,    [r8]                    ;set curr->data as first arg
            call    [rsp + 24]                  ;call free_fct to handle the removal of data

.skipFreeFct:
            cmp qword[rsp + 32],    0           ;check if prev is NULL
            jne .validPrev                      ;if not there is a valid prev node
            mov r8, [rsp]                       ;otherwise we move begin_list into a register
            mov r9, [rsp + 48]                  ;and curr->next into another
            mov [r8],   r9                      ;to set *begin_list as curr->next
            jmp .freeCurr                       ;before continuing to free step

.validPrev:
            mov r8, [rsp + 32]                  ;we move prev into r8 to access prev->next
            mov r9, [rsp + 48]                  ;we move curr->next into r9
            mov [r8 + 8], r9                    ;we set prev->next to curr->next

.freeCurr:
            mov rdi,    [rsp + 40]              ;we set current node as first argument
            call    free wrt ..plt              ;we free current node
            jmp .lastStep                       ;as we freed curr, prev stay untouched so we skip the step that actualise it in our stack

.noRemove:
            mov r8, [rsp + 40]                  ;we move current node into r8 for next instruction
            mov [rsp + 32], r8                  ;no remove were done so we store curr as prev before last step

.lastStep:
            mov r8, [rsp + 48]                  ;we move curr->next into r8 for next step
            mov [rsp + 40], r8                  ;we set curr to curr->next
            jmp .mainLoop                       ;and continue to loop through the list

.endRemoveIf:
            add rsp,    56                      ;deallocating space we used before exiting the function
            ret