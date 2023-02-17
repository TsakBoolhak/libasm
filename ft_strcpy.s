	global ft_strcpy

	section .text
ft_strcpy:

.init:	push rbp
	mov	rax,	rdi
	mov	r11,	0

.loop:	mov	r10b,	byte [rsi + r11]
	mov	byte [rdi + r11],	r10b
	cmp	byte [rsi + r11],	0
	je	.end
        inc	r11
	jmp	.loop

.end: pop rbp
ret
