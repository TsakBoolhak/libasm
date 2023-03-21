#include <libasm.h>
#include <stddef.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>

int	strcpyTester(int argCount, char **argVector)
{
	int	ret;
	char	buffer[4096] = {0};
	char	copy[4096] = {0};
	char	*copyPtr = buffer;

	puts("ENTERING STRCPY TESTER");
	for (int i = 1; i < argCount; ++i)
	{
		ret = strlen(argVector[i]);
		if (ret < 4096)
		{
			printf("Original : \"%s\"\n", argVector[i]);
			copyPtr = ft_strcpy(copy, argVector[i]);
			printf("Copy : \"%s\"\n", copyPtr);
		}
		else
		{
			copy[4095] = '\0';
		}
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
			size_t len = strlen(buffer);
			if (len < 4096)
			{
				copyPtr = ft_strcpy(copy, buffer);
				printf("Copy : \"%s\"\n", copyPtr);
			}
		}	
		
	} while (ret > 0);
	return 0;
}
