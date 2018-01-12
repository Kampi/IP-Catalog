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

#define AXI_VGA_S00_AXI_SLV_REG0_OFFSET                 0
#define AXI_VGA_S00_AXI_SLV_REG1_OFFSET                 4
#define AXI_VGA_S00_AXI_SLV_REG2_OFFSET                 8
#define AXI_VGA_S00_AXI_SLV_REG3_OFFSET                 12
#define AXI_VGA_S00_AXI_SLV_REG4_OFFSET                 16
#define AXI_VGA_S00_AXI_SLV_REG5_OFFSET                 20
#define AXI_VGA_S00_AXI_SLV_REG6_OFFSET                 24
#define AXI_VGA_S00_AXI_SLV_REG7_OFFSET                 28

#define CONFIG							                 AXI_VGA_S00_AXI_SLV_REG2_OFFSET
#define ADDRESS							                 AXI_VGA_S00_AXI_SLV_REG0_OFFSET
#define DATA							                 AXI_VGA_S00_AXI_SLV_REG1_OFFSET

#define axivga_mReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#define axivga_mWriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))

/*******************************************************************************/
/*                    F U N C T I O N   D E C L A R A T I O N S                */
/*******************************************************************************/

Axivga_Config* VGA_LookupConfig(u16 DeviceId);
u8 VGA_CfgInitialize(Axivga* InstancePtr, Axivga_Config* Config, u32 EffectiveAddr);

void VGA_WriteCharacter(Axivga *InstancePtr, char Character, u32 Position, u32 Color);
void VGA_WriteString(Axivga *InstancePtr, char* Message, u32 Position, u32 Color);

u32 VGA_ReadCursor(Axivga *InstancePtr);
void VGA_SoftReset(Axivga *InstancePtr);

#endif /* AXIVGA_H_ */