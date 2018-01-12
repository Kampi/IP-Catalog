/*******************************************************************************/
/*
*
* @file axivga_sinit.c
*
* This file contains the implementation of the Axivga driver's static
* initialization functionality.
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

#include "xparameters.h"
#include "axivga.h"

/*******************************************************************************/
/*                             V A R I A B L E S                               */
/*******************************************************************************/

extern Axivga_Config Axivga_ConfigTable[];

/*******************************************************************************/
/*
*
*
*
* @param	DeviceId is a pointer to the Axivga instance
*
* @return	Pointer to device configuration
*
* @note		None.
*
********************************************************************************/
Axivga_Config* Axivga_LookupConfig(u16 DeviceId)
{
	Axivga_Config* CfgPtr = NULL;
	u32 Index;

	for (Index=0; Index < 1; Index++) 
	{
		if (Axivga_ConfigTable[Index].DeviceId == DeviceId) 
		{
			CfgPtr = &Axivga_ConfigTable[Index];
			break;
		}
	}

	return CfgPtr;
}