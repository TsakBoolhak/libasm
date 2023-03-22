#ifdef BONUS
# include <libasm_bonus.h>
# include <libasm_tester_bonus.h>
#else
# include <libasm.h>
# include <libasm_tester.h>
#endif

#include <stdio.h>

int main(int ac, char **av)
{
	strdupTester(ac, av);
	puts("");
	strlenTester(ac, av);
	puts("");
	strcpyTester(ac, av);
	puts("");
	strcmpTester(ac, av);
	puts("");
	writeTester(ac, av);
	puts("");
	readTester(ac, av);
	#ifdef BONUS
	puts("");
	atoiBaseTester(ac, av);
	puts("");
	listTester(ac, av);
	#endif
	return 0;
}
