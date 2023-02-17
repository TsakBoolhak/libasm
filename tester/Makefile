SRCS =	srcs/ft_strlenTester.c \
	srcs/ft_strcpyTester.c \
	srcs/ft_strcmpTester.c \
	srcs/ft_writeTester.c \
	srcs/ft_readTester.c \
	srcs/ft_strdupTester.c \
	srcs/main.c

OBJS = ${SRCS:.c=.o}

CFLAGS = -Wall -Wextra -Wpedantic -Werror -no-pie

INCLUDES = -Iincludes

CC = gcc

LIBASM_PATH = ../

%.o: %.c
	${CC} ${CFLAGS} ${INCLUDES} -c ${<:.c=.c} -o ${<:.c=.o}

NAME = tester

LIB = -L${LIBASM_PATH} -lasm

RM = rm -f

${NAME}: ${OBJS}
	${MAKE} -C ${LIBASM_PATH}
	${CC} ${CFLAGS} ${INCLUDES} -o ${NAME} ${OBJS} ${LIB}


all:	${NAME}

clean:
	${MAKE} clean -C ${LIBASM_PATH}
	${RM} ${OBJS}

fclean:	clean
	${MAKE} fclean -C ${LIBASM_PATH}
	${RM} write.output ft_write.output ft_read.output
	${RM} ${NAME}

re:	fclean all

PHONY:	all clean fclean re
