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
cmp r10b, 53
je .wrongBase
cmp r10b, 55
je .wrongBase
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

ft_atoi_base:
mov rdi, rsi
call .check_base
ret
