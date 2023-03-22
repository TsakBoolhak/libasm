SRCS =	srcs/ft_strlenTester.c \
	srcs/ft_strcpyTester.c \
	srcs/ft_strcmpTester.c \
	srcs/ft_writeTester.c \
	srcs/ft_readTester.c \
	srcs/ft_strdupTester.c \
	srcs/main.c

SRCS_BONUS = 	srcs/ft_atoiBaseTester.c \
				srcs/ft_listTester.c

OBJS = ${SRCS:.c=.o}

OBJS_BONUS = ${SRCS_BONUS:.c=.o}

DEP = ${OBJS:.o=.d} ${OBJS_BONUS:.o=.d}

CFLAGS = -MMD -Wall -Wextra -Wpedantic -Werror -g3

INCLUDES = -Iincludes -I${LIBASM_PATH}includes 

CC = gcc

LIBASM_PATH = ../

%.o: %.c
	${CC} ${CFLAGS} ${INCLUDES} -c ${<:.c=.c} -o ${<:.c=.o}

NAME = tester
NAME_BONUS = tester_bonus

LIB = -L${LIBASM_PATH} -lasm
LIB_BONUS = -L${LIBASM_PATH} -lasm_bonus

RM = rm -f

${NAME}: ${OBJS}
	${MAKE} -C ${LIBASM_PATH}
	${RM} srcs/main.o
	${CC} ${CFLAGS} ${INCLUDES} -c srcs/main.c -o srcs/main.o
	${CC} ${CFLAGS} ${INCLUDES} -o ${NAME} ${OBJS} ${LIB}

${NAME_BONUS}: ${OBJS} ${OBJS_BONUS}
	${MAKE} bonus -C ${LIBASM_PATH}
ifndef BONUS
	${RM} srcs/main.o
	${CC} ${CFLAGS} ${INCLUDES} -D BONUS=1 -c srcs/main.c -o srcs/main.o
endif
	${CC} ${CFLAGS} ${INCLUDES} -o ${NAME_BONUS} ${OBJS} ${OBJS_BONUS} ${LIB_BONUS}

all:	${NAME}

bonus: ${NAME_BONUS}

clean:
	${MAKE} clean -C ${LIBASM_PATH}
	${RM} ${OBJS} ${DEP}

clean_bonus:
	${MAKE} clean_bonus -C ${LIBASM_PATH}
	${RM} ${OBJS} ${OBJS_BONUS} ${DEP}

fclean:	clean
	${MAKE} fclean -C ${LIBASM_PATH}
	${RM} write.output ft_write.output ft_read.output
	${RM} ${NAME}

fclean_bonus:	clean_bonus
	${MAKE} fclean_bonus -C ${LIBASM_PATH}
	${RM} write.output ft_write.output ft_read.output
	${RM} ${NAME_BONUS}

re:	fclean all

re_bonus:	fclean_bonus bonus

-include ${DEP}

PHONY:	all bonus clean clean_bonus fclean fclean_bonus re re_bonus
