	global	ft_strcmp

	section	.text
ft_strcmp:

.init:	mov	rax,	0
	mov	r10,	0
	mov	r11,	0

.loop:	mov	r10b,	byte [rsi + r11]
	mov	al,	byte [rdi + r11]
	sub	eax,	r10d
	cmp	r10b,	0
	je	.end
	cmp	eax,	0
	jne	.end
	inc	r11
	jmp	.loop

.end:	ret	
