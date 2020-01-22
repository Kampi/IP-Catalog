----------------------------------------------------------------------------------
-- Company:             https://www.kampis-elektroecke.de
-- Engineer:            Daniel Kampert
-- 
-- Create Date:         15.01.2020 11:04:53
-- Design Name: 
-- Module Name:         Top - Top_Arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description:         Simple clock counter.
-- 
-- Dependencies: 
-- 
-- Revision:
--  Revision 0.01 - File Created
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
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top is
    Generic (    LIMIT  : INTEGER := 16
            );
    Port    (   Clock   : in STD_LOGIC;
                ResetN  : in STD_LOGIC;
                Overflow: out STD_LOGIC
            );
end Top;

architecture Top_Arch of Top is

    signal Count        : INTEGER := 0;
    signal Overflow_Int   : STD_LOGIC := '0';

begin

    process(Clock)
    begin
        if(rising_edge(Clock)) then
            if(ResetN = '0') then
                Overflow_Int <= '0';
            else
                if(Count < LIMIT) then
                    Count <= Count + 1;
                else
                    Count <= 0;
                    Overflow_Int <= not Overflow_Int;
                end if;
            end if;
        end if;
    end process;
    
    Overflow <= Overflow_Int;
end Top_Arch;