----------------------------------------------------------------------------------
-- Company:             https://www.kampis-elektroecke.de
-- Engineer:            Daniel Kampert
--
-- Create Date:         28.04.2017 23:31:52
-- Design Name: 
-- Module Name:         Debounce - Debounce_Arch
-- Project Name: 
-- Target Devices:      XC7Z010CLG400-1
-- Tool Versions:       Vivado 2019.2
-- Description:         I/O debounce module.
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity Debounce is
    Generic (   BOUNCETIME : INTEGER    := 100                      -- Number of clock cycles as bounce time
                );
    Port (  Clock       : in STD_LOGIC;                             -- Interface clock signal
            nReset      : in STD_LOGIC;                             -- Interface reset (active low)
            BounceIn    : in STD_LOGIC;                             -- Input for bouncing signal
            DebounceOut : out STD_LOGIC                             -- Output for debounced signal
            );
end Debounce;

architecture Debounce_Arch of Debounce is
begin
    process
        variable BounceCounter  : INTEGER   := 0;
    begin
        wait until rising_edge(Clock);
        if(BounceIn = '1') then
            BounceCounter := BounceCounter + 1;

            if(BounceCounter = BOUNCETIME) then
                DebounceOut <= '1';
            else
                DebounceOut <= '0';
            end if;
        else
            BounceCounter := 0;

            DebounceOut <= '0';
        end if;
           
        if(nReset = '0') then
            BounceCounter := 0;
        end if;
    end process;
end Debounce_Arch;