#include <libasm.h>
#include <libasm_tester.h>

int main(int ac, char **av)
{
	strlenTester(ac, av);
	strcpyTester(ac, av);
	strcmpTester(ac, av);
	writeTester(ac, av);
	readTester(ac, av);
	return 0;
}
