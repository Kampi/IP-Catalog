----------------------------------------------------------------------------------
-- Company:             https://www.kampis-elektroecke.de
-- Engineer:            Daniel Kampert
-- 
-- Create Date:         01.02.2020 22:17:18
-- Design Name: 
-- Module Name:         AXI4S_ROM - AXI4S_ROM_Arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions:       Vivado 2019.2
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
--  Revision            0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AXI4S_ROM is
    Generic (   WIDTH   : INTEGER := 32
                );
    Port (  ACLK    : in STD_LOGIC;
            ARESETn : in STD_LOGIC;
            TVALID  : out STD_LOGIC;
            TREADY  : in STD_LOGIC;
            TDATA   : out STD_LOGIC_VECTOR((WIDTH - 1) downto 0);
            TLAST   : out STD_LOGIC
            );
end AXI4S_ROM;

architecture AXI4S_ROM_Arch of AXI4S_ROM is

    type Array_t is array(0 to 15) of STD_LOGIC_VECTOR((WIDTH - 1) downto 0);
    signal ROM : Array_t;

begin


end AXI4S_ROM_Arch;