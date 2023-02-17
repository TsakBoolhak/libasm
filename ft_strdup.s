global ft_strdup
extern ft_strlen
extern ft_strcpy
extern malloc

section .text
ft_strdup:
push rbp
mov rax, 0
push rdi
call ft_strlen
inc rax
mov rdi, rax
sub rsp, 8
call malloc
add rsp, 8
pop rsi
cmp rax, 0
je .end
mov rdi, rax
call ft_strcpy
mov rax, rdi
.end: pop rbp
ret