#include "xparameters.h"
#include "axisegment.h"

int main(void)
{
	AxiSegment Display;

	if(AxiSegment_CfgInitialize(&Display, AxiSegment_LookupConfig(XPAR_AXI_SEGMENT_0_DEVICE_ID)) == XST_SUCCESS)
	{
		AxiSegment_Write(&Display, 0x18);
	}

	while(1)
	{
	}

	return 0;
}