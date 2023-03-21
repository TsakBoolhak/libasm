#include <libasm.h>
#include <stddef.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int	strdupTester(int argCount, char **argVector)
{
	ssize_t	ret;
	char	buffer[4096];
	// ssize_t copy;
	char	*copy;

	puts("ENTERING STRDUP TESTER");
	for (int i = 1; i < argCount; ++i)
	{
			printf("Original : \"%s\"\n", argVector[i]);
			copy = ft_strdup(argVector[i]);
			if (copy)
			{
				printf("Copy : \"%s\"\n ", copy);
				// for (size_t i = 0; i < strlen(argVector[i]); ++i)
				// {
				// 	printf("%d ", (int)copy[i]);
				// 	fflush(stdout);
				// }
				// printf("\n");
			}
			else
				printf("Copy failed!\n");
			free(copy);
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
			copy = ft_strdup(buffer);
			if (copy)
				printf("Copy : \"%s\"\n", copy);
			else
				printf("Copy failed!\n");
			free(copy);
		}	
		
	} while (ret > 0);
	return 0;
}
