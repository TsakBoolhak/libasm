			extern __errno_location

			global	ft_write
			;ssize_t     ft_write(int fd, const void *buf, size_t count)
			;rdi => fd , rsi => buf, rdx => count

			section	.text

	ft_write:
.init:
			push	rbp							;realign stack and save stack frame
			mov	rax,	1						;set rax to 1 to call write syscall (which takes same arguments as ft_write)
			syscall								;calling write syscall
			cmp	rax,	-1						;check if write failed
			jg	.end							;if not we can return
			neg	rax								;if write syscall fail it returns a negative value, by negating it we have the corresponding errno value
			mov	rdi,	rax						;store it in rdi cause rax will be changed by next call
			call	__errno_location wrt ..plt	;this call take no argument and return the address of errno
			mov [rax],	rdi						;we can now change errno value
			mov rax,	-1						;and set rax to return -1

.end:
			pop	rbp								;set back stack frame to its original state
			ret	
