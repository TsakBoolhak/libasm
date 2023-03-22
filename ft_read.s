			extern __errno_location

			global	ft_read
			;ssize_t     ft_read(int fd, void *buf, size_t count)
			;rdi => fd , rsi => buf , rdx => count

			section	.text


	ft_read:
.init:
			push	rbp							;realign stack and save stack frame
			xor	rax,	rax						;set rax to 0 to call read syscall (which takes same arguments as ft_read)
			syscall								;calling read syscall
			cmp	rax,	-1						;check if read failed
			jg	.end							;if not we can return
			neg	rax								;if read syscall fail it returns a negative value, by negating it we have the corresponding errno value
			mov rdi,	rax						;store it in rdi cause rax will be changed by next call
			call	__errno_location wrt ..plt	;this call take no argument and return the address of errno
			mov	[rax],	rdi						;we can now change errno value
			mov rax,	-1						;and set rax to return -1

.end:
			pop	rbp								;set back stack frame to its original state
			ret