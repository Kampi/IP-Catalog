/*******************************************************************************/
/*
*
* @file axivga.c
*
* Functions in this file are the minimum required functions for the
* axivga driver.
*
* @note 	None.
*
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who    Date		Changes
* ----- -----  -------- -----------------------------------------------
* 1.00  dk     02/14/15 First release
*
* </pre>
*
********************************************************************************/


/*******************************************************************************/
/*                             I N C L U D E S                                 */
/*******************************************************************************/

#include "axivga.h"


/*******************************************************************************/
/*
*
*
*
* @param	
*
* @return	
*
* @note		None.
*
********************************************************************************/
u8 VGA_Initialize(axivga* InstancePtr, u16 DeviceId)
{
	u8 Status;
	axivga_Config* ConfigPtr = VGA_LookupConfig(DeviceId);

	Xil_AssertNonvoid(InstancePtr != NULL);

	if (ConfigPtr == (axivga_Config*) NULL) 
	{
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	Status = VGA_CfgInitialize(InstancePtr, ConfigPtr,  ConfigPtr->BaseAddress);
	axivga_mWriteReg(InstancePtr->BaseAddress, CONFIG, 0x03);

	return Status;
}

/*******************************************************************************/
/*
*
*
*
* @param	
*
* @return	
*
* @note		None.
*
********************************************************************************/
u8 VGA_CfgInitialize(axivga *InstancePtr, axivga_Config *Config, u32 EffectiveAddr)
{
    Xil_AssertNonvoid(InstancePtr != NULL);

    InstancePtr->BaseAddress = EffectiveAddr;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}

/*******************************************************************************/
/*
*
*
*
* @param	DeviceId is a pointer to the XUartPs instance
*
* @return	Pointer to device configuration
*
* @note		None.
*
********************************************************************************/
axivga_Config* VGA_LookupConfig(u16 DeviceId)
{
    	u8 Index;
    	axivga_Config* CfgPtr = NULL;
    	extern axivga_Config axivga_ConfigTable[];

	for (Index = 0; Index < XPAR_AXI_VGA_NUM_INSTANCES; Index++) 
	{
		if (axivga_ConfigTable[Index].DeviceId == DeviceId) 
		{
			CfgPtr = &axivga_ConfigTable[Index];
			break;
		}
	}

	return CfgPtr;
}

/*******************************************************************************/
/*
*
*
*
* @param	
*
* @return	None.
*
* @note		None.
*
********************************************************************************/

void VGA_WriteCharacter(axivga *InstancePtr, char Character, u32 Position, u32 Color)
{
	axivga_mWriteReg(InstancePtr->BaseAddress, ADDRESS, Position);
	axivga_mWriteReg(InstancePtr->BaseAddress, DATA, (Color << 8) + Character);
}

/*******************************************************************************/
/*
*
*
*
* @param	
*
* @return	None.
*
* @note		None.
*
********************************************************************************/

void VGA_WriteString(axivga *InstancePtr, char *Message, u32 Position, u32 Color)
{
	while(*(Message) != '\0')
	{
		axivga_mWriteReg(InstancePtr->BaseAddress, ADDRESS, Position++);
		axivga_mWriteReg(InstancePtr->BaseAddress, DATA, (Color << 8) + *(Message++));
	}
}

/*******************************************************************************/
/*
*
*
*
* @param
*
* @return
*
* @note		None.
*
********************************************************************************/
u32 VGA_ReadCursor(axivga *InstancePtr)
{
	return axivga_mReadReg(InstancePtr->BaseAddress, ADDRESS);
}

/*******************************************************************************/
/*
*
*
*
* @param
*
* @return	None.
*
* @note		None.
*
********************************************************************************/
void VGA_SoftReset(axivga *InstancePtr)
{
	axivga_mReadReg(InstancePtr->BaseAddress, CONFIG);
}
