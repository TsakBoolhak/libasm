#include <libasm.h>
#include <libasm_tester.h>
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
	puts("");
	atoiBaseTester(ac, av);
	puts("");
	listTester(ac, av);
	return 0;
}
