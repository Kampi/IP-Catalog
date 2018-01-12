/*******************************************************************************/
/*
*
* @file axivga.h
*
* This header file contains identifiers and basic driver functions (or
* macros) that can be used to access the AXI VGA device through the Device
* Config Interface of the Zynq.
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

#ifndef AXIVGA_HW_H_
#define AXIVGA_HW_H_

/*******************************************************************************/
/*                             I N C L U D E S                                 */
/*******************************************************************************/


/*******************************************************************************/
/*                             D E F I N E S                                   */
/*******************************************************************************/

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

#define WEA                                             (1 << 0)
#define RESET                                           (1 << 7)

#define axivga_mReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#define axivga_mWriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))


#endif /* AXIVGA_HW_H_ */
