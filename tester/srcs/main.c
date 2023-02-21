#include <libasm.h>
#include <libasm_tester.h>

int main(int ac, char **av)
{
	strdupTester(ac, av);
	strlenTester(ac, av);
	strcpyTester(ac, av);
	strcmpTester(ac, av);
	writeTester(ac, av);
	readTester(ac, av);
	atoiBaseTester(ac, av);
	return 0;
}
