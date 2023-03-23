            global  ft_list_size
            ;int    ft_list_size(t_list *begin_list);
            ;rdi => begin_list
            
            ;typedef struct  s_list
            ;{
            ;   void            *data;
            ;   struct s_list   *next;
            ;}               t_list;

            section .text

    ft_list_size:
.init:
            xor rax,    rax         ;Zero init rax
            cmp rdi,    0           ;check if begin_list is NULL
            je  .end                ;in tht case we consider the list is empty (size 0) 
            inc rax                 ;otherwise the list has at least one element
.loop:
            cmp dword[rdi + 8], 0   ;check if current node has a non null next node
            je  .end                ;if next is NULL we counted all nodes
            inc rax                 ;otherwise we increment rax
            mov rdi,    [rdi + 8]   ;and set current to current->next
            jmp .loop               ;before continuing loop
.end:
            ret