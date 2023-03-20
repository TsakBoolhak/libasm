            extern ft_strlen
            extern ft_strcpy
            extern malloc
        
            global ft_strdup
            ;char *      ft_strdup(const char *src)
            ; rdi => src

            section .text

    ft_strdup:
.init:
            xor     rax,    rax         ;Zero init rax
            push    rdi                 ;save rdi for further need AND re align stack before call
            call    ft_strlen           ;get src's length
            inc     rax                 ;increment rax for the null terminator
            mov     rdi,    rax         ;set rax as malloc's argument
            call    malloc wrt ..plt    ;allocate enough space on heap for the copy
            pop     rsi                 ;pop src as ft_strcpy's second argument (src)
            cmp     rax,    0           ;check if malloc failed
            je      .end                ;if so we can just return NULL
            mov     rdi,    rax         ;move allocated pointer as ft_strcpy's first argument (dst)
            sub     rsp,    8           ;align stack as previous push has been popped
            call    ft_strcpy           ;copy src into our heap allocated pointer
            add     rsp,    8           ;deallocated this useless space     
.end:
            ret
