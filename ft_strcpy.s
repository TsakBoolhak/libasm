			global ft_strcpy
			;char *      ft_strcpy(char *dest, const char *src)
			;rdi => dest
			;rsi => src

			section .text

	ft_strcpy:

.init:
			mov	rax,	rdi					;set dest as return
			xor	r11,	r11					;Zero init r11

.loop:
			mov	r10b,	byte [rsi + r11]	;store src[r11] into r10b
			mov	byte [rdi + r11],	r10b	;set dst[r11] to r10b
			cmp	byte [rsi + r11],	0		;check if we just copied the null terminator
			je	.end						;if so the copy is over	
        	inc	r11							;otherwise we increment r11 because next loop's turn
			jmp	.loop						;continue the loop

.end:
			ret
