-- (c) Copyright 1995-2016 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: www.kampis-elektroecke.de:Kampis-Elektroecke:VGA:1.0
-- IP Revision: 7

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY VGA_0 IS
  PORT (
    Clock_VGA : IN STD_LOGIC;
    Reset : IN STD_LOGIC;
    Mode : IN STD_LOGIC;
    Display_DataIn : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    Display_Addr : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
    HSync : OUT STD_LOGIC;
    VSync : OUT STD_LOGIC;
    RGB : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END VGA_0;

ARCHITECTURE VGA_0_arch OF VGA_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF VGA_0_arch: ARCHITECTURE IS "yes";
  COMPONENT VGA IS
    GENERIC (
      Color_Width : INTEGER;
      ROM_Address_Width : INTEGER;
      ROM_Data_Width : INTEGER;
      Char_Size : INTEGER;
      Max_Char_x : INTEGER;
      Max_Char_y : INTEGER
    );
    PORT (
      Clock_VGA : IN STD_LOGIC;
      Reset : IN STD_LOGIC;
      Mode : IN STD_LOGIC;
      Display_DataIn : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
      Display_Addr : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
      HSync : OUT STD_LOGIC;
      VSync : OUT STD_LOGIC;
      RGB : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
  END COMPONENT VGA;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF VGA_0_arch: ARCHITECTURE IS "VGA,Vivado 2016.1";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF VGA_0_arch : ARCHITECTURE IS "VGA_0,VGA,{}";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF Clock_VGA: SIGNAL IS "xilinx.com:signal:clock:1.0 Clock_VGA CLK";
  ATTRIBUTE X_INTERFACE_INFO OF Reset: SIGNAL IS "xilinx.com:signal:reset:1.0 Reset RST";
BEGIN
  U0 : VGA
    GENERIC MAP (
      Color_Width => 16,
      ROM_Address_Width => 11,
      ROM_Data_Width => 8,
      Char_Size => 8,
      Max_Char_x => 80,
      Max_Char_y => 60
    )
    PORT MAP (
      Clock_VGA => Clock_VGA,
      Reset => Reset,
      Mode => Mode,
      Display_DataIn => Display_DataIn,
      Display_Addr => Display_Addr,
      HSync => HSync,
      VSync => VSync,
      RGB => RGB
    );
END VGA_0_arch;
