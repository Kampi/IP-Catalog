--Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2015.3 (lin64) Build 1368829 Mon Sep 28 20:06:39 MDT 2015
--Date        : Thu Nov 26 22:54:20 2015
--Host        : daniel-VirtualBox running 64-bit Ubuntu 14.04.3 LTS
--Command     : generate_target Display_RAM.bd
--Design      : Display_RAM
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Display_RAM is
  port (
    Display_Clock_Read : in STD_LOGIC;
    Display_Clock_Write : in STD_LOGIC;
    Display_Data_In : in STD_LOGIC_VECTOR ( 23 downto 0 );
    Display_Data_Out : out STD_LOGIC_VECTOR ( 23 downto 0 );
    Display_Read_Addr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    Display_Read_Write : in STD_LOGIC_VECTOR ( 0 to 0 );
    Display_Write_Addr : in STD_LOGIC_VECTOR ( 12 downto 0 )
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of Display_RAM : entity is "Display_RAM,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=Display_RAM,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,synth_mode=Global}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of Display_RAM : entity is "Display_RAM.hwdef";
end Display_RAM;

architecture STRUCTURE of Display_RAM is
  component Display_RAM_blk_mem_gen_0_0 is
  port (
    clka : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 12 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 23 downto 0 );
    clkb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 12 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 23 downto 0 )
  );
  end component Display_RAM_blk_mem_gen_0_0;
  signal addra_1 : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal addrb_1 : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal blk_mem_gen_0_doutb : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal clka_1 : STD_LOGIC;
  signal clkb_1 : STD_LOGIC;
  signal dina_1 : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal wea_1 : STD_LOGIC_VECTOR ( 0 to 0 );
begin
  Display_Data_Out(23 downto 0) <= blk_mem_gen_0_doutb(23 downto 0);
  addra_1(12 downto 0) <= Display_Write_Addr(12 downto 0);
  addrb_1(12 downto 0) <= Display_Read_Addr(12 downto 0);
  clka_1 <= Display_Clock_Write;
  clkb_1 <= Display_Clock_Read;
  dina_1(23 downto 0) <= Display_Data_In(23 downto 0);
  wea_1(0) <= Display_Read_Write(0);
blk_mem_gen_0: component Display_RAM_blk_mem_gen_0_0
     port map (
      addra(12 downto 0) => addra_1(12 downto 0),
      addrb(12 downto 0) => addrb_1(12 downto 0),
      clka => clka_1,
      clkb => clkb_1,
      dina(23 downto 0) => dina_1(23 downto 0),
      doutb(23 downto 0) => blk_mem_gen_0_doutb(23 downto 0),
      wea(0) => wea_1(0)
    );
end STRUCTURE;
