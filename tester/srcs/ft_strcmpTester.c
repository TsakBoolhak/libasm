#include <libasm.h>
#include <stddef.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>

int	strcmpTester(int argc, char **argv)
{
	int	ret;
	char	buffer[4096] = {0};
	char	copy[4096] = {0};
	char	*activeBuf = buffer;

	for (int i = 1; i + 1 < argc; ++i)
	{
		ret = ft_strcmp(argv[i], argv[i + 1]);
		printf("ft_strcmp(\"%s\",\"%s\") = %d\n", argv[i], argv[i + 1], ret);
		printf("strcmp(\"%s\",\"%s\") = %d\n", argv[i], argv[i + 1], strcmp(argv[i], argv[i + 1]));
	}
	do
	{
		printf("Input: ");
		fflush(stdout);
		ret = read(0, activeBuf, 4095);
	       	if (ret >= 0)
		{
			activeBuf[ret] = '\0';
			if (ret > 0 && activeBuf[ret - 1] == '\n')
			{
				activeBuf[ret - 1] = '\0';
			}
			if (activeBuf == buffer)
			{
				activeBuf = copy;
			}
			else
			{
				activeBuf = buffer;
				printf("ft_strcmp(\"%s\", \"%s\") = %d\n", buffer, copy, ft_strcmp(buffer, copy));
				printf("strcmp(\"%s\", \"%s\") = %d\n", buffer, copy, strcmp(buffer, copy));
			}
		}
	} while (ret > 0);
	return 0;
}
