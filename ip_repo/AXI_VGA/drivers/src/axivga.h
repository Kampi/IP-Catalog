/*
 * axivga.h
 *
 *  Copyright (C) Daniel Kampert, 2018
 *	Website: www.kampis-elektroecke.de
 *  File info: 

  GNU GENERAL PUBLIC LICENSE:
  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program. If not, see <http://www.gnu.org/licenses/>.

  Errors and commissions should be reported to DanielKampert@kampis-elektroecke.de
 */

#ifndef AXIVGA_H_
#define AXIVGA_H_

 #include "xil_io.h"
 #include "xstatus.h"
 #include "xil_types.h"
 #include "xparameters.h"

 #include "axivga_hw.h"

typedef struct {
	u16 DeviceId;			/* Unique ID  of device */
	u32 BaseAddress;		/* Device base address */
} AxiVga_Config;

typedef struct {
    AxiVga_Config Config;   /* Axivga_Config of current device */
	u32 IsReady;			/* Device is initialized and ready */
} AxiVga;

AxiVga_Config* Axivga_LookupConfig(u16 DeviceId);
u8 Axivga_CfgInitialize(AxiVga* InstancePtr, AxiVga_Config* Config, u32 EffectiveAddr);

void Axivga_WriteCharacter(AxiVga *InstancePtr, char Character, u32 Position, u32 Color);
void Axivga_WriteString(AxiVga *InstancePtr, char* Message, u32 Position, u32 Color);

u32 Axivga_ReadCursor(AxiVga *InstancePtr);
void Axivga_SoftReset(AxiVga *InstancePtr);

#endif /* AXIVGA_H_ */