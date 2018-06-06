----------------------------------------------------------------------------------
-- Company:         www.kampis-elektroecke.de
-- Engineer:        Daniel Kampert
-- 
-- Create Date:     13.11.2017 23:06:22
-- Design Name: 
-- Module Name:     ClockDivider - ClockDivider_Arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions:   Vivado 2016.4
-- Description:     Simple clock divider
--                  Formula for output frequency f_out = f_in / Prescaler
-- 
-- Dependencies: 
-- 
-- Revision:
--  Revision 0.01   13.11.2017      File Created
--
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

entity ClockDivider is
    Generic ( PRESCALER : INTEGER := 2
            );
    Port ( Clock_In : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Clock_Out : out STD_LOGIC
           );
end ClockDivider;

architecture ClockDivider_Arch of ClockDivider is

    signal Counter : INTEGER := ((PRESCALER / 2) - 1);
    signal Clock_Int : STD_LOGIC := '0';

begin

    NoPrescale : if(Prescaler = 1) generate
        Clock_Int <= Clock_In when (Reset = '0') else '0';
    end generate;

    Prescaling : if(PRESCALER > 1) generate
        process(Clock_In, Reset)
        begin
            if(Reset = '1') then
                Counter <= ((PRESCALER / 2) - 1);
                Clock_Int <= '0';
            elsif(rising_edge(Clock_In)) then
                Counter <= Counter - 1;
                    
                if(Counter = 0) then
                    Clock_Int <= not Clock_Int;
                    Counter <= ((PRESCALER / 2) - 1);
                end if;
            end if;
        end process;
    end generate;

    Clock_Out <= Clock_Int;

end ClockDivider_Arch;