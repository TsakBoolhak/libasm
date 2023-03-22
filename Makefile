SRCS =	ft_strlen.s \
    	ft_strcpy.s \
    	ft_write.s \
    	ft_read.s \
		ft_strdup.s \
    	ft_strcmp.s

SRCS_BONUS =	ft_atoi_base_bonus.s \
				ft_list_push_front_bonus.s \
				ft_list_size_bonus.s \
				ft_list_remove_if_bonus.s \
				ft_list_sort_bonus.s

OBJS = ${SRCS:.s=.o}

OBJS_BONUS = ${SRCS_BONUS:.s=.o}

ASMFLAGS = -felf64 -gDwarf

INCLUDES = -Iincludes

INCLUDES_BONUS = -Iincludes_bonus

ASMC = nasm

%.o: %.s
	${ASMC} ${ASMFLAGS} -o $@ -s $<

NAME = libasm.a

NAME_BONUS = libasm_bonus.a

RM = rm -f

${NAME}: ${OBJS}
	ar rcs ${NAME} ${OBJS}

${NAME_BONUS}: ${OBJS} ${OBJS_BONUS}
	ar rcs ${NAME_BONUS} ${OBJS} ${OBJS_BONUS}

all:	${NAME}

bonus: ${NAME_BONUS}

clean:
	${RM} ${OBJS}

clean_bonus:
	${RM} ${OBJS} ${OBJS_BONUS}

fclean:	clean
	${RM} ${NAME}

fclean_bonus:	clean_bonus
	${RM} ${NAME_BONUS}

re:	fclean all

re_bonus: fclean_bonus bonus

PHONY:	all bonus clean clean_bonus fclean fclean_bonus re re_bonus
