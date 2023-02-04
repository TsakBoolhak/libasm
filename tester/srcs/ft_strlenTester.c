#include <libasm.h>
#include <stddef.h>
#include <stdio.h>
#include <unistd.h>

int	strlenTester(int argCount, char **argVector)
{
	int	ret;
	char	buffer[4096] = {0};

	for (int i = 1; i < argCount; ++i)
	{
		printf("\"%s\" => length %zu\n", argVector[i], ft_strlen(argVector[i]));
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
			printf("\"%s\" => length %zu\n", buffer, ft_strlen(buffer));
		}	
		
	} while (ret > 0);
	return 0;
}
