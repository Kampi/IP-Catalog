#include "AXI_VGA.h"

int main(void)
{
	VGAInit();

	VGAWriteString("Hallo Welt\n", 0, 0xFFFF);

	return 0;
}
