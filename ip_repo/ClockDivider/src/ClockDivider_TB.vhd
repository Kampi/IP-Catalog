----------------------------------------------------------------------------------
-- Company:             www.kampis-elektroecke.de
-- Engineer:            Daniel Kampert 
-- 
-- Create Date:         09.02.2018 09:31:35
-- Design Name: 
-- Module Name:         ClockDivider_TB - ClockDivider_TB_Arch
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

entity ClockDivider_TB is
--  Port ( );
end ClockDivider_TB;

architecture ClockDivider_TB_Arch of ClockDivider_TB is

    -- Inputclock (50 Mhz)
    constant CLK_PERIODE : TIME := 20 ns;
    
    -- Clock Prescaler
    constant PRESCALER : INTEGER := 2;

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

    DUT : ClockDivider generic map (PRESCALER => PRESCALER)
                        port map (  Clock_In => Clock,
                                    Reset => Reset,
                                    Clock_Out => Clock_Out
                                    );

    -- Create the clock for the device
    Clock_Generation : process
    begin
        wait for CLK_PERIODE / 2;
        Clock <= not Clock;
    end process;

    -- Simulate some data transmission
    Stimulus : process
    begin
        -- Reset device
        Reset <= '1';
        wait for CLK_PERIODE * 100;
        Reset <= '0';
        wait for CLK_PERIODE * 100;
    end process;

end ClockDivider_TB_Arch;
