----------------------------------------------------------------------------------
-- Company:             https://www.kampis-elektroecke.de
-- Engineer:            Daniel Kampert
-- 
-- Create Date:         04.03.2020 09:00:02
-- Design Name: 
-- Module Name:         AXIS_Slave - AXIS_Slave_Arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 		Vivado 2019.2
-- Description:         Simple AXIS slave IP core.
--
-- Dependencies: 
-- 
-- Revision:
--  Revision 		     0.01 - File Created
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

entity AXIS_Slave is
    Generic (   FIFO_SIZE   : INTEGER := 32
                );
    Port (  ACLK        : in STD_LOGIC;
            ARESETn     : in STD_LOGIC;
			TDATA_RXD   : in STD_LOGIC_VECTOR(31 downto 0);
            TREADY_RXD  : out STD_LOGIC;
            TVALID_RXD  : in STD_LOGIC;
            TLAST_RXD   : in STD_LOGIC;
            Index       : in STD_LOGIC_VECTOR(4 downto 0);
            DataOut     : out STD_LOGIC_VECTOR(31 downto 0)
            );
end AXIS_Slave;

architecture AXIS_Slave_Arch of AXIS_Slave is

    type State_t is (State_Reset, State_Ready, State_WaitForValid);
    type FIFO_t is array(0 to (FIFO_SIZE - 1)) of STD_LOGIC_VECTOR(31 downto 0);

    signal CurrentState     : State_t   := State_Reset;

    signal FIFO             : FIFO_t    := (others => (others => '0'));
    signal FIFO_Counter     : INTEGER   := 0;

begin

    process(ACLK)
    begin
        if(rising_edge(ACLK)) then
            if(ARESETn = '0') then
                CurrentState <= State_Reset;
            else
                case CurrentState is
                    when State_Reset =>
                        FIFO <= (others => (others => '0'));
                        FIFO_Counter <= 0;

                        CurrentState <= State_Ready;

                    when State_Ready =>
                        TREADY_RXD <= '1';

                        CurrentState <= State_WaitForValid;

                    when State_WaitForValid =>
                        if(TVALID_RXD = '1') then
                            TREADY_RXD <= '0';
                            FIFO(FIFO_Counter) <= TDATA_RXD;
                            
                            if((FIFO_Counter = (FIFO_SIZE - 1)) or (TLAST_RXD = '1')) then
                                FIFO_Counter <= 0;
                            else
                                FIFO_Counter <= FIFO_Counter + 1;
                            end if;
                            
                            CurrentState <= State_Ready;
                        else
                            CurrentState <= State_WaitForValid;
                        end if;

                end case;
            end if;
        end if;
    end process;

    DataOut <= FIFO(to_integer(UNSIGNED(Index)));
end AXIS_Slave_Arch;