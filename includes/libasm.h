#ifndef LIBASM_H
# define LIBASM_H
# include <stddef.h>
# include <unistd.h>

size_t	ft_strlen(const char *str);
char *ft_strcpy(char *dest, const char *src);
int ft_strcmp(const char *s1, const char *s2);
ssize_t ft_write(int fd, const void *buf, size_t count);
ssize_t ft_read(int fd, void *buf, size_t count);
// ssize_t ft_strdup(const char *src);
char *ft_strdup(const char *src);

#endif