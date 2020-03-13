----------------------------------------------------------------------------------
-- Company:             https://www.kampis-elektroecke.de
-- Engineer:            Daniel Kampert
-- 
-- Create Date:         04.03.2020 09:00:02
-- Design Name: 
-- Module Name:         Top - Top_Arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 		Vivado 2019.2
-- Description:         AXI-Stream data viewer.
--
-- Dependencies: 
-- 
-- Revision:
--      Revision        0.01 - File Created
--
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
    Port (  aclk        : in STD_LOGIC;
            aresetn     : in STD_LOGIC;

            -- AXI-Stream interface
            TDATA_RXD   : in STD_LOGIC_VECTOR(31 downto 0);
            TREADY_RXD  : out STD_LOGIC;
            TVALID_RXD  : in STD_LOGIC;
            TLAST_RXD   : in STD_LOGIC;

            NextWord    : in STD_LOGIC;
            DataOut     : out STD_LOGIC_VECTOR(31 downto 0)
            );
end Top;

architecture Top_Arch of Top is

    type State_t is (Reset, WaitForOne, WaitForValid, WaitForZero);

    signal CurrentState     : State_t   := Reset;

begin

    process(aclk)
    begin
        if(rising_edge(aclk)) then
            if(aresetn = '0') then
                CurrentState <= Reset;
            else
                case CurrentState is
                    when Reset =>
                        DataOut <= (others => '0');

                        CurrentState <= WaitForOne;

                    when WaitForOne =>
                        if(NextWord = '1') then
                            CurrentState <= WaitForValid;
                        else
                            CurrentState <= WaitForOne;
                        end if;

                    when WaitForValid =>
                        TREADY_RXD <= '1';

                        if(TVALID_RXD = '1') then
                            CurrentState <= WaitForZero;
                        else
                            CurrentState <= WaitForValid;
                        end if;

                    when WaitForZero =>
                        TREADY_RXD <= '0';
                        DataOut <= TDATA_RXD;

                        if(NextWord = '1') then
                            CurrentState <= WaitForZero;
                        else
                            CurrentState <= WaitForOne;
                        end if;

                end case;
            end if;
        end if;
    end process;
end Top_Arch;