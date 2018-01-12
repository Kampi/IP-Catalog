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
* 1.00  dk     09/01/18 First release
*
* </pre>
*
********************************************************************************/


/*******************************************************************************/
/*                             I N C L U D E S                                 */
/*******************************************************************************/

#include "axivga.h"

/*****************************************************************************/
/**
*
* This function initializes a specific Axivga device/instance. This function
* must be called prior to using the XADC device.
*
* @param	InstancePtr is a pointer to the Axivga instance.
* @param	ConfigPtr points to the Axivga device configuration structure.
* @param	EffectiveAddr is the device base address in the virtual memory
*		    address space. If the address translation is not used then the
*		    physical address is passed.
*		    Unexpected errors may occur if the address mapping is changed
*		    after this function is invoked.
*
* @return
*		- XST_SUCCESS if successful.
*
* @note		The user needs to first call the XAdcPs_LookupConfig() API
*		    which returns the Configuration structure pointer which is
*		    passed as a parameter to the Axivga_CfgInitialize() API.
*
******************************************************************************/
u8 VGA_CfgInitialize(Axivga* InstancePtr, Axivga_Config* ConfigPtr, u32 EffectiveAddr)
{
    u32 RegValue;

	Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);
    
	InstancePtr->Config.DeviceId = ConfigPtr->DeviceId;
    InstancePtr->Config.BaseAddress = EffectiveAddr;

    axivga_mWriteReg(InstancePtr->Config.BaseAddress, CONFIG, 0x03);

    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
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

void VGA_WriteCharacter(Axivga* InstancePtr, char Character, u32 Position, u32 Color)
{
	axivga_mWriteReg(InstancePtr->Config.BaseAddress, ADDRESS, Position);
	axivga_mWriteReg(InstancePtr->Config.BaseAddress, DATA, (Color << 8) + Character);
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

void VGA_WriteString(Axivga* InstancePtr, char *Message, u32 Position, u32 Color)
{
	while(*(Message) != '\0')
	{
		axivga_mWriteReg(InstancePtr->Config.BaseAddress, ADDRESS, Position++);
		axivga_mWriteReg(InstancePtr->Config.BaseAddress, DATA, (Color << 8) + *(Message++));
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
u32 VGA_ReadCursor(Axivga* InstancePtr)
{
	return axivga_mReadReg(InstancePtr->Config.BaseAddress, ADDRESS);
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
void VGA_SoftReset(Axivga* InstancePtr)
{
	axivga_mReadReg(InstancePtr->Config.BaseAddress, CONFIG);
}
