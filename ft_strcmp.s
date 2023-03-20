			global	ft_strcmp
			;int         ft_strcmp(const char *s1, const char *s2)
			;rdi => s1, rsi => s2

			section	.text

	ft_strcmp:
.init:
			xor	eax,	eax					;Zero init eax		
			xor	r10,	r10					;Zero init r10
			xor	r11,	r11					;Zero init r11

.loop:
			mov	r10b,	byte [rsi + r11]	;store s2[r11] into r10b
			mov	al,	byte [rdi + r11]		;store s1[r11] into al
			sub	eax,	r10d				;store into eax the result of s1[r11] - s2[r11]
			cmp	r10b,	0					;check if s2[r11] was the null terminator (no need to check both as if one is null we stop and if its not then there will be a diff if the other one is)
			je	.end						;if so we return the diff (which could be 0 if both are terminator)
			cmp	eax,	0					;check if there was a diff between two chars
			jne	.end						;if so we return it
			inc	r11							;increment r11
			jmp	.loop						;continue loop

.end:
			ret	
