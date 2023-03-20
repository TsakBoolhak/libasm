            global ft_list_push_front
            ;void    ft_list_push_front(t_list **begin_list, void *data);
            ;rdi => begin_list rsi => data
            ;typedef struct  s_list
            ;{
            ;   void            *data;
            ;   struct s_list   *next;
            ;}

            extern malloc

            section .text

    ft_list_push_front:
.init:
            push    rbp                 ;realign stack while and save stack frame
            cmp rdi,    0               ;check if begin_list is NULL
            je  .end
            push    rdi                 ;save rdi in stack before calling malloc
            push    rsi                 ;save rsi in stack before calling malloc
            mov rdi,    16              ;move 16 in rdi to prepare heap allocation of 16 bytes (size of our t_list struct)
            call    malloc wrt ..plt    ;call malloc to allocate our new node
            pop rsi                     ;restore data into rsi register
            pop rdi                     ;restore begin_list into rdi register
            cmp rax,    0               ;check if malloc failed
            je  .end                    ;if so we return immediatly
            mov [rax],  rsi             ;store data into our newly allocated node's data
            mov r11,    [rdi]           ;store *begin_list into a register
            mov [rax + 8],  r11         ;set our newly allocated node's next as *begin_list's node
            mov [rdi],  rax             ;set *begin_list as our new node
.end:
            pop rbp                     ;set back stack frame at its initial state
            ret