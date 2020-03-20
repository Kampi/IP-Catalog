----------------------------------------------------------------------------------
-- Company:             https://www.kampis-elektroecke.de
-- Engineer:            Daniel Kampert
-- 
-- Create Date:         04.03.2020 09:00:02
-- Design Name: 
-- Module Name:         AXIS_Viewer - AXIS_Viewer_Arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 		Vivado 2019.2
-- Description:         AXI-Stream data viewer.
--
-- Dependencies: 
-- 
-- Revision:
--  Revision            0.01 - File Created
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

entity AXIS_Viewer is
    Port (  ACLK        : in STD_LOGIC;
            ARESETn     : in STD_LOGIC;

            -- AXI-Stream interface
            TDATA_RXD   : in STD_LOGIC_VECTOR(31 downto 0);
            TREADY_RXD  : out STD_LOGIC;
            TVALID_RXD  : in STD_LOGIC;
            TLAST_RXD   : in STD_LOGIC;

            NextWord    : in STD_LOGIC;
            DataOut     : out STD_LOGIC_VECTOR(31 downto 0)
            );
end AXIS_Viewer;

architecture AXIS_Viewer_Arch of AXIS_Viewer is

    type State_t is (State_Reset, State_WaitForOne, State_WaitForValid, State_WaitForZero);

    signal CurrentState     : State_t   := State_Reset;

begin

    process(ACLK)
    begin
        if(rising_edge(ACLK)) then
            if(ARESETn = '0') then
                CurrentState <= State_Reset;
            else
                case CurrentState is
                    when State_Reset =>
                        DataOut <= (others => '0');

                        CurrentState <= State_WaitForOne;

                    when State_WaitForOne =>
                        if(NextWord = '1') then
                            CurrentState <= State_WaitForValid;
                        else
                            CurrentState <= State_WaitForOne;
                        end if;

                    when State_WaitForValid =>
                        TREADY_RXD <= '1';

                        if(TVALID_RXD = '1') then
                            CurrentState <= State_WaitForZero;
                        else
                            CurrentState <= State_WaitForValid;
                        end if;

                    when State_WaitForZero =>
                        TREADY_RXD <= '0';
                        DataOut <= TDATA_RXD;

                        if(NextWord = '1') then
                            CurrentState <= State_WaitForZero;
                        else
                            CurrentState <= State_WaitForOne;
                        end if;

                end case;
            end if;
        end if;
    end process;
end AXIS_Viewer_Arch;