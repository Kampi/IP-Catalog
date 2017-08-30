----------------------------------------------------------------------------------
-- Company:             www.kampis-elektroecke.de
-- Engineer:            Daniel Kampert
-- 
-- Create Date:         15.05.2016 19:57:52
-- Design Name: 
-- Module Name:         Prescaler - Prescaler_Arch
-- Project Name: 
-- Target Devices:      XC7Z010CLG400-1
-- Tool Versions: 
-- Description:         Simple Clockprescaler
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
--library UNISIM;
--use UNISIM.VComponents.all;

entity Prescaler is
    port (  
            Clock_In    :   in STD_LOGIC;
            Prescale    :   in STD_LOGIC_VECTOR(31 downto 0);
            Clock_Out   :   out STD_LOGIC
            );
end Prescaler;

architecture Prescaler_Arch of Prescaler is

    signal Counter  : integer := 0;
    signal Clock    : std_logic := '0';

begin

    process(Clock_In)
    
    begin
        if(rising_edge(Clock_In)) then
            Counter <= Counter + 1;
            
            if(Counter = ((to_integer(unsigned(Prescale)) / 2) - 1)) then
                Counter <= 0;
                Clock <= not Clock;
            end if;
        end if;
    end process;
    
    Clock_Out <= Clock;

end Prescaler_Arch;