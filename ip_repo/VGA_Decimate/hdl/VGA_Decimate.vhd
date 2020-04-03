----------------------------------------------------------------------------------
-- Company:             https://www.kampis-elektroecke.de
-- Engineer:            Daniel Kampert
-- 
-- Create Date:         08.04.2019 18:57:23
-- Design Name: 
-- Module Name:         VGA_Decimate - VGA_Decimate_Arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions:       Vivado 2019.2
-- Description:         VGA split module for Xilinx AXI4-Stream to Video Out IP.
--                      This IP core reduces the size of an AXI4-Videostream and resize 
--                      the color bytes.
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

entity VGA_Decimate is
    Generic (   INPUT_SIZE  : INTEGER := 24;
                COLOR_SIZE  : INTEGER := 8;
                OUTPUT      : INTEGER := 16;
                RED_END     : INTEGER := 4;
                GREEN_END   : INTEGER := 5;
                BLUE_END    : INTEGER := 4
                );
    Port (  Enable   : in STD_LOGIC_VECTOR(0 downto 0);
            Data_In  : in STD_LOGIC_VECTOR((INPUT_SIZE - 1) downto 0);
            Data_Out : out STD_LOGIC_VECTOR((OUTPUT - 1) downto 0)
            );
end VGA_Decimate;

architecture VGA_Decimate_Arch of VGA_Decimate is

    signal Red      : STD_LOGIC_VECTOR((COLOR_SIZE - 1) downto 0);
    signal Green    : STD_LOGIC_VECTOR((COLOR_SIZE - 1) downto 0);
    signal Blue     : STD_LOGIC_VECTOR((COLOR_SIZE - 1) downto 0);

    signal Data_Out_Int : STD_LOGIC_VECTOR((OUTPUT - 1) downto 0);

begin

    Red <= Data_In((COLOR_SIZE - 1) downto 0);
    Green <= Data_In(((2 * COLOR_SIZE) - 1) downto COLOR_SIZE);
    Blue <= Data_In(((3 * COLOR_SIZE) - 1) downto (2 * COLOR_SIZE));

    Data_Out_Int <= Blue(BLUE_END downto 0) & Green(GREEN_END downto 0) & Red(RED_END downto 0);
    Data_Out <= Data_Out_Int and Enable;

end VGA_Decimate_Arch;