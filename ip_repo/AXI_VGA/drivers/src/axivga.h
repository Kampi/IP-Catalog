/*******************************************************************************/
/*                     U P D A T E   I N F O R M A T I O N                     */
/*******************************************************************************/

// Date             	Changes
// -----------------------------------------------------------------------------
// V1.0			Initial Release


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
/*                             D E F I N E S                                   */
/*******************************************************************************/

typedef struct {
	u16 DeviceId;		/* Unique ID  of device */
	u32 BaseAddress;	/* Device base address */
} axivga_Config;

typedef struct {
	u32 BaseAddress;	/* Device base address */
	u32 IsReady;		/* Device is initialized and ready */
} axivga;

#define axivga_Base                                     XPAR_AXI_VGA_0_S00_AXI_BASEADDR

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

u8 VGA_Initialize(axivga* InstancePtr, u16 DeviceId);
u8 VGA_CfgInitialize(axivga* InstancePtr, axivga_Config* Config, u32 EffectiveAddr);
axivga_Config* VGA_LookupConfig(u16 DeviceId);

void VGA_WriteCharacter(axivga *InstancePtr, char Character, u32 Position, u32 Color);
void VGA_WriteString(axivga *InstancePtr, char* Message, u32 Position, u32 Color);

u32 VGA_ReadCursor(axivga *InstancePtr);
void VGA_SoftReset(axivga *InstancePtr);

/*******************************************************************************/
/*                        G L O B A L   V A R I A B L E S                      */
/*******************************************************************************/

/*******************************************************************************/
/*                             I N S T A N C E S                               */
/*******************************************************************************/

#endif /* AXIVGA_H_ */