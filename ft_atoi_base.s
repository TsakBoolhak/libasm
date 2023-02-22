; int	ft_atoi_base(char *str, char *base)

global ft_atoi_base

section .text

.check_base:
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
mov rax, 0
jmp .endBase
.returnBase: pop rax
cmp rax, 1
je .wrongBase 
.endBase: ret

.power:
mov rax, 1
cmp rsi, 0
je .endPower
.powerLoop: mul rdi
sub rsi, 1
cmp rsi, 0
jne .powerLoop
.endPower: ret

.getCharIndex:
mov rax, -1
.getCharIndexLoop: inc rax
cmp byte[rsi + rax], 0
je .getCharIndexNotFound
cmp dil, byte[rsi + rax]
je .endGetCharIndex
jmp .getCharIndexLoop
.getCharIndexNotFound: mov rax, -1
.endGetCharIndex: ret

.getPowerIndex:
mov r10, rsi
mov rcx, rdi
mov rsi, rdx
mov r11, -1
.getPowerIndexLoop: inc r11
mov rdi, 0
mov dil, byte[rcx + r11]
call .getCharIndex
cmp rax, -1
jne .getPowerIndexLoop
mov rax, r11
sub rax, 1
sub rax, r10
.endGetPowerIndex: ret

ft_atoi_base:
call .getPowerIndex
ret
