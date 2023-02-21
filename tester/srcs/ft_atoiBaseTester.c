#include <libasm.h>
#include <stddef.h>
#include <stdio.h>
#include <unistd.h>

int	atoiBaseTester(int argCount, char **argVector)
{
	int	ret;
	char	buffer[4096] = {0};

	for (int i = 1; i < argCount; ++i)
	{
		printf("\"%s\" => check_base ret = %d\n", argVector[i], ft_atoi_base(argVector[i], argVector[i]));
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
            printf("\"%s\" => check_base ret = %d\n", buffer, ft_atoi_base(buffer, buffer));
		}	
		
	} while (ret > 0);
	return 0;
}