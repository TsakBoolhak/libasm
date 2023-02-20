            global    ft_strlen

            section    .text
ft_strlen:
            mov   rax, 0
mainLoop:
            cmp   byte[rdi + rax], 0
            je    endLoop
            inc   rax
            jmp   mainLoop

endLoop:
            ret
