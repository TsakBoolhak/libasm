            global ft_atoi_base
            ;int     ft_atoi_base(char *str, char *base);
            ;RDI => str , rsi => base

            section .text

    ft_atoi_base:
.initAtoi:
            sub rsp,    40              ;allocating space for 2 pointers (16 bytes), 1 size_t (8 bytes) 2 ints (8 bytes), 1 int8_t (1 byte) and 7 bytes to align stack
            mov qword[rsp], rdi         ;[rsp] => str
            mov qword[rsp + 8], rsi     ;[rsp + 8] => base
            mov dword[rsp + 16],    0   ;[rsp + 16] => result
            mov qword[rsp + 24],    0  ;[rsp + 24] => i
            mov byte[rsp + 32], 1       ;[rsp + 32] => sign
            cmp rdi,    0               ;check if str is NULL
            je  .atoiEnd                ;if so we end
            cmp rsi,    0               ;check if base is NULL
            je  .atoiEnd                ;if so we end
            mov rdi,    rsi             ;set base as first argument
            call    .check_base         ;call check base that will return either 0 if base is invalid either the base length
            cmp rax,    0               ;check if base is valid
            je  .atoiEnd                ;if not we jump to the end
            mov [rsp + 20],    rax      ;[rsp + 20] => baseLen
            mov rcx,    [rsp]           ;move str into rcx to dereference it later
            mov r8, [rsp + 24]          ;r8 => i
            mov r9b,     [rcx + r8]      ;store str[i] into r9b

.skipWhiteSpaces:
            cmp r9b, 0                   ;check if we reached the null terminator
            je .atoiEnd                 ;in which case we jump to the end
            cmp r9b, 32                  ;check if we reached a space
            je  .continueSkip           ;if so we continue the loop
            cmp r9b, 9                   ;(other withespaces are between 9 and 13 included) so we compare the char with 9
            jl  .computeSign            ;if its below then its not a whitspace so its time for the compute sign loop
            cmp r9b, 13                  ;we compare the char with 13
            jg  .computeSign            ;if its greater its not a whitespace so its time for the compute sign loop
.continueSkip:
            inc r8                      ;increment i
            mov r9b,     [rcx + r8]      ;store str[i] into r9b
            jmp .skipWhiteSpaces        ;continue skipping whitespaces

.computeSign:
            cmp r9b, 0                  ;check if we reached null terminator
            je  .atoiEnd                ;in which case we jump to the end
            cmp r9b, 43                 ;check if current char is +
            je  .continueComputeSign    ;in which case we continue the loop
            cmp r9b, 45                 ;check if current char is -
            jne .computeValueInit       ;if it is not then we can start computing value
            neg byte[rsp + 32]  ;otherwise we inverse sign
.continueComputeSign:
            inc r8                      ;increment i
            mov r9b, [rcx + r8]         ;store str[i] into r9b
            jmp .computeSign            ;continue computing sign

.computeValueInit:
            mov qword[rsp + 24], r8          ;actualise i in the corresponding stack value

.computeValue:
            mov rcx, [rsp]              ;move str into rcx to dereference it
            mov r8, [rsp + 24]          ;r8 => i
            mov r9b, [rcx + r8]         ;store current char into r9b
            xor rdi, rdi                ;set rdi to zero before next step
            mov dil,    r9b             ;set current char as first argument
         ;   mov rsi,    [rsp + 8]       ;set base as second argument
            call    .getCharIndex       ;calls getCharIndex which should return the 'value' of the current char in base or -1 if its not in base
            cmp rax,    -1              ;check if the char was not valid
            je  .atoiEnd                ;in which case the conversion is over
            mov rdx,    rax             ;keep the result in rdx cause we need rax register
            mov rax,    [rsp + 16]      ;move the old result into rax
            imul eax, dword[rsp + 20]         ;multiply it by the base length
            mov dword[rsp + 16],    eax ;move the result back in the stack
            add [rsp + 16],    edx      ;add it to the result
            add qword[rsp + 24], 1      ;increment i
            jmp .computeValue           ;continue to compute the loop

.atoiEnd:
            mov rax,    [rsp + 16]      ;move result into eax
            imul    byte[rsp + 32]      ;multiply it by the sign
            add rsp,    40              ;set back the stack into its original state 
            ret

    .check_base: ; RAX : int RDI : char* base
.initcheckBase:
            mov rax,    0

.loopBase:
            mov r9b,   [rdi + rax]
            cmp r9b,   0
            je  .returnBase
            cmp r9b,   32
            je  .wrongBase
            cmp r9b,   43
            je  .wrongBase
            cmp r9b,   45
            je  .wrongBase
            cmp r9b,   9
            jl  .innerLoopBaseInit
            cmp r9b,   13
            jg  .innerLoopBaseInit
            jmp .wrongBase
.innerLoopBaseInit:
            mov r8, rax
.innerLoopBase:
            inc r8 
            cmp byte[rdi + r8], 0
            jne .innerLoopBase
            cmp r9b, [rdi + r8]
            je .wrongBase
            inc rax
            jmp .loopBase

.wrongBase:
            mov rax,    0
            jmp .endBase

.returnBase:
            cmp rax, 1
            je .wrongBase 
.endBase:
            ret

    .getCharIndex: ; RAX : int RDI : char c RSI : char * base

mov rax, 0
.getCharIndexLoop:
cmp byte[rsi + rax], 0
je .getCharIndexNotFound
cmp dil, byte[rsi + rax]
je .endGetCharIndex
inc rax
jmp .getCharIndexLoop
.getCharIndexNotFound:
mov rax, -1
.endGetCharIndex:
ret

