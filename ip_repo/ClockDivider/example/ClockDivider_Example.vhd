----------------------------------------------------------------------------------
-- Company:             www.kampis-elektroecke.de
-- Engineer:            Daniel Kampert 
-- 
-- Create Date:         09.02.2018 09:31:35
-- Design Name: 
-- Module Name:         ClockDivider_Example - ClockDivider_Example_Arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions:       Vivado 2016.4
-- Description:         Testbench for ClockDivider core
-- 
-- Dependencies: 
-- 
-- Revision:
--  Revision 0.01   09.02.2018      File Created
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

entity ClockDivider_Example is
    Port (  Clock_In : in STD_LOGIC;
            Reset : in STD_LOGIC;
            Clock_Out : out STD_LOGIC
            );
end ClockDivider_Example;

architecture ClockDivider_Example_Arch of ClockDivider_Example is

    component ClockDivider is
        Generic ( PRESCALER : INTEGER
                );
        Port ( Clock_In : in STD_LOGIC;
               Reset : in STD_LOGIC;
               Clock_Out : out STD_LOGIC
               );
    end component;

    signal Clock    :   STD_LOGIC := '0';
    signal Reset    :   STD_LOGIC := '0';
    signal Clock_Out:   STD_LOGIC := '0';

begin

    DUT : ClockDivider generic map (PRESCALER => 2)
                        port map (  Clock_In => Clock,
                                    Reset => Reset,
                                    Clock_Out => Clock_Out
                                    );

end ClockDivider_Example_Arch;
