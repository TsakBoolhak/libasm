SRCS = ft_strlen.s \
       ft_strcpy.s \
       ft_write.s \
       ft_read.s \
       ft_strcmp.s

OBJS = ${SRCS:.s=.o}

ASMFLAGS = -felf64

ASMC = nasm

%.o: %.s
	${ASMC} ${ASMFLAGS} -o $@ -s $<

NAME = libasm.a

RM = rm -f

${NAME} : ${OBJS}
	ar rcs ${NAME} ${OBJS}

all:	${NAME}

clean:
	${RM} ${OBJS}

fclean:	clean
	${RM} ${NAME}
re:	fclean all

PHONY:	all clean fclean re
