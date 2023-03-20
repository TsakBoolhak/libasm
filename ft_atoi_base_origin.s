            global ft_atoi_base
            ;int     ft_atoi_base(char *str, char *base);
            ;RDI => str , rsi => base

            section .text

    ;r10 => base_nb , r11 => sign , rcx => result r8 => i r9 => i + j
    ft_atoi_base:
.initAtoi:
            mov rcx,    rcx
            mov r11,    1
            push    rdi
            mov rdi,    rsi
            call    .check_base
            pop rdi
            mov r10,    rax
            mov rax,    0
            cmp r10,    0
            je  .atoiEnd
            mov r8, -1
.skipWhiteSpaces:
            inc r8
            cmp byte[rdi + r8], 0
            je .atoiEnd
            cmp byte[rdi + r8], 32
            je  .skipWhiteSpaces
            cmp byte[rdi + r8], 9
            jl  .computeSign
            cmp byte[rdi + r8], 13
            jg  .computeSign
            jmp .skipWhiteSpaces
.computeSign:
            sub r8, 1
.computeSignLoop:
            inc r8
            cmp byte[rdi + r8], 0
            je  .atoiEnd
            cmp byte[rdi + r8], 43
            je  .computeSignLoop
            cmp byte[rdi + r8], 45
            jne .computeValue
            imul    r11,   -1
            jmp .computeSignLoop
.computeValue:
            mov r9, r8
            sub r9, 1
.computeValueLoop:
            inc r9
            mov rax,    0
            mov al, byte[rdi + r9]
            push    rdi
            mov rdi,   rax
            call    .getCharIndex
            pop rdi
            cmp rax,    -1
            je  .atoiEnd
            push    rax
            mov rax,    rcx
            mul r10
            mov rcx,    rax
            pop rax
            add rcx,    rax
            jmp .computeValueLoop
.atoiEnd:
            mov rax,    rcx
            imul    r11
            ret

.check_base: ; RAX : int RDI : char* base
push r10
mov r10, 0
mov rax, 0
.loopBase: push rax
mov r10b, [rdi + rax]
cmp r10b, 0
je .returnBase
cmp r10b, 32
je .wrongBase
cmp r10b, 43
je .wrongBase
cmp r10b, 45
je .wrongBase
cmp r10b, 9
jl .innerLoopBase
cmp r10b, 13
jg .innerLoopBase
jmp .wrongBase
.innerLoopBase: inc rax
cmp r10b, [rdi + rax]
je .wrongBase
cmp byte[rdi + rax], 0
jne .innerLoopBase
pop rax
inc rax
jmp .loopBase
.wrongBase: pop rax
.wrongBase2: mov rax, 0
jmp .endBase
.returnBase: pop rax
cmp rax, 1
je .wrongBase2 
.endBase: pop r10
ret

.getCharIndex: ; RAX : int RDI : char c RSI : char * base
mov rax, -1
.getCharIndexLoop: inc rax
cmp byte[rsi + rax], 0
je .getCharIndexNotFound
cmp dil, byte[rsi + rax]
je .endGetCharIndex
jmp .getCharIndexLoop
.getCharIndexNotFound: mov rax, -1
.endGetCharIndex: ret

