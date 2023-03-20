            global    ft_strlen
            ;size_t      ft_strlen(const char *str)
            ;rdi => str

            section    .text

    ft_strlen:
.init:
            xor     rax,    rax             ; 0 init rax
.mainLoop:
            cmp     byte[rdi + rax],    0   ; check for null terminator
            je      .endLoop                ; null terminator reached just need to return rax
            inc     rax                     ; increment rax
            jmp     .mainLoop               ; continue loop

.endLoop:
            ret
