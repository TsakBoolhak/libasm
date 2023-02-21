#include <libasm.h>
#include <stddef.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <stdlib.h>

int	readTester(int argc, char **argv)
{
	ssize_t	ret;
	char	buffer[4096] = {0};
	int	fd;
	char *buf = 0;

	fd = open("ft_read.output", O_CREAT | O_WRONLY, S_IRWXU | S_IRWXG | S_IRWXO);
	if (!fd)
	{
		puts("Encountered Error");
		perror(NULL);
		exit(1);
	}

	for (int i = 1; i < argc; ++i)
	{
		write(1, argv[i], strlen(argv[i]));
		write(1,"\n", 1);
		write(fd, argv[i], strlen(argv[i]));
		write(fd,"\n", 1);
	}
	do
	{
		printf("Input: ");
		fflush(stdout);
		ret = ft_read(0, buffer, 4095);
	       	if (ret >= 0)
		{
			buffer[ret] = '\0';
			if (ret > 0 && buffer[ret - 1] == '\n')
			{
				buffer[ret - 1] = '\0';
			}
			else if (ret > 0)
			{
				write(1, "\n", 1);
			}
			write(1, buffer, strlen(buffer));
			fflush(stdout);
			printf("\nret = %ld\n", ret);
			write(fd, buffer, strlen(buffer));
			write(fd,"\n", 1);
		}
	} while (ret > 0);
	close(fd);
	fd = open("ft_read.output", O_RDONLY);
	if (!fd)
	{
		puts("Encountered Error");
		perror(NULL);
		exit(1);
	}
	do
	{
		ret = ft_read(fd, buffer, 4095);
	       	if (ret >= 0)
		{
			buffer[ret] = '\0';
			if (ret > 0 && buffer[ret - 1] == '\n')
			{
				buffer[ret - 1] = '\0';
			}
			else if (ret > 0)
			{
				write(1, "\n", 1);
			}
			write(1, buffer, strlen(buffer));
			fflush(stdout);
			printf("\nret = %ld\n", ret);
			write(fd, buffer, strlen(buffer));
		}
		
	} while (ret > 0);
	close(fd);
	errno = 0;
	ret = read(33, buffer, 4095);
	printf("failed call, REAL ret = %ld\n", ret);
	perror("REAL perror: ");
	errno = 0;
	ret = ft_read(33, buffer, 4095);
	printf("failed call, MINE ret = %ld\n", ret);
	perror("MINE perror: ");
	fd = open("ft_read.output", O_RDONLY);
	errno = 0;
	ret = read(fd, buf, 4095);
	printf("failed call, REAL ret = %ld\n", ret);
	perror("REAL perror: ");
	close(fd);
	fd = open("ft_read.output", O_RDONLY);
	errno = 0;
	ret = ft_read(fd, buf, 4095);
	printf("failed call, MINE ret = %ld\n", ret);
	perror("MINE perror: ");
	close(fd);
	return 0;
}
