global ft_list_size ;  int         ft_list_size(t_list *begin_list);

section .text

ft_list_size: mov rax, 0
cmp rdi, 0
je .end
inc rax
.loop: cmp dword[rdi + 8], 0
je .end
inc rax
mov rdi, [rdi + 8]
jmp .loop
.end: ret