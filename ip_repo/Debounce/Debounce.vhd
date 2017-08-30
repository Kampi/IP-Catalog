----------------------------------------------------------------------------------
-- Company:             www.kampis-elektroecke.de
-- Engineer:            Daniel Kampert
-- 
-- Create Date:         28.04.2017 23:31:52
-- Design Name: 
-- Module Name:         Debounce - Debounce_Arch
-- Project Name: 
-- Target Devices:      XC7Z010CLG400-1
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity Debounce is
    Port ( Clock : in  STD_LOGIC;
           Signal_In : in  STD_LOGIC;
           Signal_Out : out  STD_LOGIC);
end Debounce;

architecture Debounce_Arch of Debounce is
   signal Counter : unsigned(23 downto 0);
begin
   process(Clock)
   begin
      if rising_edge(Clock) then
         if Signal_In = '1' then
            if Counter = x"FFFFFF" then
               Signal_Out <= '1';
            else
               Signal_Out <= '0';
            end if;
            Counter <= Counter + 1;
         else
            Counter <= (others => '0');
            Signal_Out <= '0';
         end if;
      end if;
   end process;
end Debounce_Arch;

