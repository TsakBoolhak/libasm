#include <libasm.h>
#include <stddef.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>

int	atoiBaseTester(int argCount, char **argVector)
{
	int	ret;
	char	buffer[4096] = {0};
	char	copy[4096] = {0};

	for (int i = 1; i + 1 < argCount; i += 2)
	{
		printf("atoi_base(%s, %s) = %d\n", argVector[i], argVector[i + 1], ft_atoi_base(argVector[i], argVector[i + 1]));
	}
	do
	{
		printf("Input Str: ");
		fflush(stdout);
		ret = read(0, buffer, 4095);
	    if (ret >= 0)
		{
			buffer[ret] = '\0';
			if (ret > 0 && buffer[ret - 1] == '\n')
			{
				buffer[ret - 1] = '\0';
			}
		}
		else
		{
			continue;
		}
		printf("Input Base: ");
		fflush(stdout);
		ret = read(0, copy, 4095);
	    if (ret >= 0)
		{
			copy[ret] = '\0';
			if (ret > 0 && copy[ret - 1] == '\n')
			{
				copy[ret - 1] = '\0';
			}
		}
		else
		{
			continue;
		}
		printf("atoi_base(%s, %s) = %d\n", buffer, copy, ft_atoi_base(buffer, copy));
	} while (ret > 0);
	return 0;
}