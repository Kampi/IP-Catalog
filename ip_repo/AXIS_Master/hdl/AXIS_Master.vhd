----------------------------------------------------------------------------------
-- Company:             https://www.kampis-elektroecke.de
-- Engineer:            Daniel Kampert
-- 
-- Create Date:         04.03.2020 09:00:02
-- Design Name: 
-- Module Name:         AXIS_Master - AXIS_Master_Arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 		Vivado 2019.2
-- Description:         Simple AXIS master IP core.
-- 
-- Dependencies: 
-- 
-- Revision:
-- 	Revision 			0.01 - File Created
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

entity AXIS_Master is
    Generic (   LENGTH  : INTEGER := 100
                );
    Port (  ACLK        : in STD_LOGIC;
            ARESETn     : in STD_LOGIC;
            Trigger     : in STD_LOGIC;
            TDATA_TXD   : out STD_LOGIC_VECTOR(31 downto 0);
            TREADY_TXD  : in STD_LOGIC;
            TVALID_TXD  : out STD_LOGIC;
            TLAST_TXD   : out STD_LOGIC
            );
end AXIS_Master;

architecture AXIS_Master_Arch of AXIS_Master is

    type State_t is (State_Reset, State_WaitForTriggerHigh, State_WaitForTriggerLow, State_WaitForReady, State_WaitForSlave);

    signal TransmitState    : State_t   := State_Reset;

    signal Counter          : INTEGER   := 0;

begin

    process(ACLK)
    begin
        if(rising_edge(ACLK)) then
            if(ARESETn = '0') then
                TransmitState <= State_Reset;
            else
                case TransmitState is
                    when State_Reset =>
                        Counter <= 0;
                        TDATA_TXD <= (others => '0');
                        TVALID_TXD <= '0';
                        TLAST_TXD <= '0';
                        TransmitState <= State_WaitForTriggerHigh;

                    when State_WaitForTriggerHigh =>
                        if(Trigger = '1') then
                            TransmitState <= State_WaitForTriggerLow;
                        else
                            TransmitState <= State_WaitForTriggerHigh;
                        end if;
                   
                    when State_WaitForTriggerLow =>
                        if(Trigger = '0') then
                            TransmitState <= State_WaitForReady;
                        else
                            TransmitState <= State_WaitForTriggerLow;
                        end if;                 

                    when State_WaitForReady =>
                        TDATA_TXD <= std_logic_vector(to_unsigned(Counter, 32));
                        TVALID_TXD <= '1';
                        
                        if(Counter < (LENGTH - 1)) then
                            TLAST_TXD <= '0';
                        else
                            TLAST_TXD <= '1';
                        end if;

                        TransmitState <= State_WaitForSlave;

                    when State_WaitForSlave =>
                        if(TREADY_TXD = '1') then
                            TVALID_TXD <= '0';
                            TLAST_TXD <= '0';
                            
                            if(Counter < (LENGTH - 1)) then
                                Counter <= Counter + 1;
                                TransmitState <= State_WaitForReady;
                            else
                                Counter <= 0;
                                TransmitState <= State_WaitForTriggerHigh;
                            end if;
                        else
                            TransmitState <= State_WaitForSlave;
                        end if;
                end case;
            end if;
        end if;
    end process;
end AXIS_Master_Arch;