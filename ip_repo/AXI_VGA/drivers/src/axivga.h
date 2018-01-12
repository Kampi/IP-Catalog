/*******************************************************************************/
/*
*
* @file axivga.h
*
* Header file for AXI VGA driver.
* 
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

#ifndef AXIVGA_H_
#define AXIVGA_H_

/*******************************************************************************/
/*                             I N C L U D E S                                 */
/*******************************************************************************/

#include "xparameters.h"
#include "xil_types.h"
#include "xstatus.h"
#include "xil_io.h"

#include "axivga_hw.h"

/*******************************************************************************/
/*                        G L O B A L   V A R I A B L E S                      */
/*******************************************************************************/

/*******************************************************************************/
/*                             I N S T A N C E S                               */
/*******************************************************************************/

/*******************************************************************************/
/*                             D E F I N E S                                   */
/*******************************************************************************/

typedef struct {
	u16 DeviceId;		/* Unique ID  of device */
	u32 BaseAddress;	/* Device base address */
} Axivga_Config;

typedef struct {
    Axivga_Config Config;   /**< Axivga_Config of current device */
	u32 IsReady;		/* Device is initialized and ready */
} Axivga;

/*******************************************************************************/
/*                    F U N C T I O N   D E C L A R A T I O N S                */
/*******************************************************************************/

Axivga_Config* Axivga_LookupConfig(u16 DeviceId);
u8 Axivga_CfgInitialize(Axivga* InstancePtr, Axivga_Config* Config, u32 EffectiveAddr);

void Axivga_WriteCharacter(Axivga *InstancePtr, char Character, u32 Position, u32 Color);
void Axivga_WriteString(Axivga *InstancePtr, char* Message, u32 Position, u32 Color);

u32 Axivga_ReadCursor(Axivga *InstancePtr);
void Axivga_SoftReset(Axivga *InstancePtr);

#endif /* AXIVGA_H_ */