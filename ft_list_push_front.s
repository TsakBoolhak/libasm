global ft_list_push_front
extern malloc

section .text

ft_list_push_front:
push rdi
push rsi
mov rdi, 16
sub rsp, 8
call malloc wrt ..plt
add rsp, 8
pop rsi
pop rdi
cmp rax, 0
je .end
mov [rax], rsi
mov r11, [rdi]
mov [rax + 8], r11
mov [rdi], rax
.end : ret