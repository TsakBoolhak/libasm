            global ft_list_sort
            ;void ft_list_sort(t_list **begin_list, int (*cmp)())
            ;rdi => begin_list , rsi => cmp

            ;typedef struct  s_list
            ;{
            ;   void            *data;
            ;   struct s_list   *next;
            ;}

            section .text

    ft_list_sort:
.init:
            sub rsp,    72                  ;allocating spaces for 8 pointers + 8 bytes to align stack
            cmp rdi,    0                   ;check begin_list is NULL
            je  .sortEnd                    ;if so we have nothing to do
            cmp qword[rdi], 0               ;check if *begin_list is NULL
            je  .sortEnd                    ;if so we also have nothing to do
            cmp qword[rdi + 8], 0           ;check if (*begin_list)->next is NULL
            je  .sortEnd                    ;if so the list only has 1 element so still no need to sort
            cmp rsi,    0                   ;check if cmp function is NULL
            je  .sortEnd                    ;if so we won't be able to sort so we jump to the end
            mov qword[rsp], rdi             ;[rsp] => begin_list
            mov r11,    [rdi]               ;we move *begin_list into r11 for next instruction
            mov qword[rsp + 8], r11         ;[rsp + 8] => curr
            mov qword[rsp + 16], 0          ;[rsp + 16] => currPrev (set as NULL for now)
            mov qword[rsp + 40],    r11     ;[rsp + 40] => toCheckPrev (set as curr for now)
            mov r11,    [r11 + 8]           ;we move *(begin_list)->next into r11 for the next instructions
            mov [rsp + 24], r11             ;[rsp + 24] => currNext
            mov [rsp + 32], r11             ;[rsp + 32] => toCheck (curr->next for now)
            mov r11,    [r11 + 8]           ;we move CurrNext->next into r11 for the next instruction
            mov [rsp + 48], r11             ;[rsp + 48] => toCheckNext
            mov [rsp + 56], rsi             ;[rsp + 56] => cmp func

.outterLoop:
            cmp qword[rsp + 8], 0           ;check if curr is NULL
            je  .sortEnd                    ;if so the sort is over
            mov r11,    [rsp + 8]           ;we move curr into r11 for next instructions
            mov qword[rsp + 40],    r11     ;assign curr to toCheckPrev
            mov r11,    [r11 + 8]           ;move curr->next into r11 for next instruction
            mov qword[rsp + 24],    r11     ;set currNext
            cmp r11,    0                   ;check if currNext is NULL
            je  .sortEnd                    ;in which case the sort is over
            mov qword[rsp + 32],    r11     ;assign curr->next to toCheck

.innerLoop:
            cmp qword[rsp + 32],    0       ;check if toCheck is NULL
            je  .endOutterLoop              ;in which case we must prepare to continue the outter loop
            mov r11,    [rsp + 32]          ;we move toCheck into r11 for next instruction
            mov r11,    [r11 + 8]           ;we set r11 to toCheck->next for next instruction
            mov [rsp + 48], r11             ;assign toCheck->next to toCheckNext
            mov r11,    [rsp + 8]           ;we move curr into r11 for next instruction
            mov rdi,    [r11]               ;we set curr->data as first argument 
            mov r11,    [rsp + 32]          ;we move toCheck into r11 for next instruction
            mov rsi,    [r11]               ;we set toCheck->data as second argument
            call    qword[rsp + 56]         ;we call the compare function
            cmp eax,    0                   ;we compare the return of the function with 0
            jle .skipSwap                   ;if curr->data <= toCheck->data then we continue without swapping the nodes

.swap:
            mov rdi,    [rsp + 8]           ;rdi => curr
            mov rsi,    [rsp + 24]          ;rsi => currNext
            mov rdx,    [rsp + 16]          ;rdx => currPrev
            mov r9, [rsp + 32]              ;r9 => toCheck
            mov r10,    [rsp + 48]          ;r10 => toCheckNext
            mov r11,    [rsp + 40]          ;r11 => toCheckPrev
            cmp rdx,    0                   ;check if currPrev is null
            jne .validPrev                  ;if not we have further linking to do
            mov r8, [rsp]                   ;otherwise that means we are swapping the first node so we need to update *begin_list, then we store begin_list into r8
            mov [r8],   r9                  ;and assign toCheck to *begin_list
            jmp .nextStep

.validPrev:
            mov qword[rdx + 8], r9          ;CurPrev->next = toCheck

.nextStep:
            mov [r11 + 8],  rdi             ;we assign curr to toCheckPrev->next (if the two nodes are next to each others that assign curr to curr->next but tht's fixed two instructions below)
            mov [r9 + 8],   rsi             ;we assign currNext to toCheck->next (if the two nodes are next to each others that assign currNext to currNext->next which is a problem we have to fix further)
            mov [rdi + 8],  r10             ;we assign toCheckNext to curr->next (which fix the case two instructions above)
            cmp r11,    rdi                 ;we compare toCheckPrev and curr
            jne .otherStep                  ;if they are not the same that means they were not next to each others so we skip the fix of that edge case
            mov [r9 + 8],  rdi              ;otherwise we assign curr as toCheck->next

.otherStep:
            mov qword[rsp + 8], r9          ;update curr (so its the old toCheck)
            mov r8, [r9 + 8]                ;move toCheck->next into r8 for next instruction
            mov qword[rsp + 24],    r8      ;update currNext
            mov qword[rsp + 32],    rdi     ;update toCheck

.skipSwap:
            mov r11,    [rsp + 32]          ;move toCheck into r11 for next instruction
            mov qword[rsp + 40],    r11     ;set toCheckPrev as the old toCheck
            mov r11,    [r11 + 8]           ;set r11 to toCheck->next for next instruction
            mov qword[rsp + 32],    r11     ;set toCheck to toCheck->next
            jmp .innerLoop                  ;continue the inner loop

.endOutterLoop:
            mov r11,    [rsp + 8]           ;move curr into r11 for next instruction
            mov qword[rsp + 16],    r11     ;assign curr to currPrev
            mov r11,    [r11 + 8]           ;move curr->next to r11 for next instruction
            mov qword[rsp + 8], r11         ;assign curr->next to curr
            jmp .outterLoop                 ;and continue the outter loop

.sortEnd:
            add rsp,    72                  ;deallocating space
            ret