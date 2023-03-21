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

int	writeTester(int argc, char **argv)
{
	ssize_t	ret;
	char	buffer[4096] = {0};
	int		fdTest;
	int		fdReal;

	puts("ENTERING WRITE TESTER");
	fdTest = open("ft_write.output", O_CREAT | O_WRONLY, S_IRWXU | S_IRWXG | S_IRWXO);
	if (!fdTest)
	{
		puts("Encountered Error");
		perror(NULL);
		exit(1);
	}

	fdReal = open("write.output", O_CREAT | O_WRONLY, S_IRWXU | S_IRWXG | S_IRWXO);
	if (!fdReal)
	{
		puts("Encountered Error");
		perror(NULL);
		close(fdTest);
		exit(1);
	}
	for (int i = 1; i < argc; ++i)
	{
		ret = ft_write(1, argv[i], strlen(argv[i]));
		fflush(stdout);
		printf("\nret = %ld\n", ret);
		ft_write(fdTest, argv[i], strlen(argv[i]));
		write(fdReal, argv[i], strlen(argv[i]));
	}
	do
	{
		printf("Input: ");
		fflush(stdout);
		ret = read(0, buffer, 4095);
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
			ret = ft_write(1, buffer, strlen(buffer));
			fflush(stdout);
			printf("\nret = %ld\n", ret);
			ft_write(fdTest, buffer, strlen(buffer));
			write(fdReal, buffer, strlen(buffer));
		}
	} while (ret > 0);
	close(fdTest);
	close(fdReal);
	puts("now let's check if errno is set correctly with two tests that will make write call fail");
	errno = 0;
	ret = write(-1, buffer, 4095);
	printf("failed call, REAL ret = %ld\n", ret);
	perror("REAL perror: ");
	errno = 0;
	ret = ft_write(-1, buffer, 4095);
	printf("failed call, MINE ret = %ld\n", ret);
	perror("MINE perror: ");
	fdTest = open("/dev/full", O_WRONLY);
	if (fdTest)
	{
		errno = 0;
		ret = write(fdTest, "this will fail", 15);
		printf("failed call, REAL ret = %ld\n", ret);
		perror("REAL perror: ");
		close(fdTest);
	}
	fdTest = open("/dev/full", O_WRONLY);
	if (fdTest)
	{
		errno = 0;
		ret = ft_write(fdTest, "this will fail", 15);
		printf("failed call, MINE ret = %ld\n", ret);
		perror("MINE perror: ");
		close(fdTest);
	}
	return 0;
}
