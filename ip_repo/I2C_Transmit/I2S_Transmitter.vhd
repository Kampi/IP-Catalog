----------------------------------------------------------------------------------
-- Company:             www.kampis-elektroecke.de
-- Engineer:            Daniel Kampert
-- 
-- Create Date:         11.05.2016 09:04:43
-- Design Name: 
-- Module Name:         I2S_Transmitter - I2S_Transmitter_Arch
-- Project Name: 
-- Target Devices:      XC7Z010CLG400-1
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity I2S_Transmitter is
    generic (  
        DATA_WIDTH_PER_CHANNEL  : INTEGER := 32;
        CLOCK_PRESCALER         : INTEGER := 8
    );
    port (
        Clock_Input :   in STD_LOGIC;
        Reset       :   in STD_LOGIC;
        Data        :   in STD_LOGIC_VECTOR(((DATA_WIDTH_PER_CHANNEL * 2) - 1) downto 0); 
        Tx_Interrupt:   out STD_LOGIC;
        SCLK        :   out STD_LOGIC;
        LRCLK       :   out STD_LOGIC;
        SOUT        :   out STD_LOGIC
    );
end entity;

architecture I2S_Transmitter_Arch of I2S_Transmitter is

    signal Data_Left    :   std_logic_vector(((DATA_WIDTH_PER_CHANNEL) - 1) downto 0) := (others => '0');
    signal Data_Right   :   std_logic_vector(((DATA_WIDTH_PER_CHANNEL) - 1) downto 0) := (others => '0');
    
    signal LRCLK_Signal :   std_logic := '0';
    signal SOUT_Signal  :   std_logic := '0';
    signal Ready_Signal :   std_logic := '0';
    signal Counter      :   integer := 0;
    
    signal I2S_Clock    :   std_logic := '0';
    
    component Prescaler is
        port (  
                Clock_In    :   in STD_LOGIC;
                Prescale    :   in STD_LOGIC_VECTOR(31 downto 0);
                Clock_Out   :   out STD_LOGIC
                );
    end component Prescaler;

begin
 
Prescale_MCLK: 
    component Prescaler port map (
                Clock_In => Clock_Input,
                Prescale => std_logic_vector(to_unsigned(CLOCK_PRESCALER, 32)),
                Clock_Out => I2S_Clock
                ); 

LRCLK_Logic:

        process (I2S_Clock)
        begin
            if(falling_edge(I2S_Clock)) then
                if(Reset = '1') then
                    Counter <= 0;
                else
                    
                    if(Counter = (DATA_WIDTH_PER_CHANNEL - 1)) then
                        LRCLK_Signal <= '1';
                    end if;
                    
                    if(Counter = ((DATA_WIDTH_PER_CHANNEL * 2) - 1)) then
                        LRCLK_Signal <= '0';
                    end if;
                    
                    if(Counter = ((DATA_WIDTH_PER_CHANNEL * 2) - 1)) then
                        Counter <= 0;
                    else
                       Counter <= Counter + 1;  
                    end if;
                    
                end if; 
            end if;
        end process;
    
Load_and_shift_out_Data:

        process(I2S_Clock)
        begin
            if(falling_edge(I2S_Clock)) then
                if(Reset = '1') then
                    Data_Left <= (others => '0');
                    Data_Right <= (others => '0');
                    Ready_Signal <= '0';
                else
                    if(LRCLK_Signal = '1') then
                        Data_Right <= Data_Right((DATA_WIDTH_PER_CHANNEL - 2) downto 0) & '0';  
                        SOUT_Signal <= Data_Right(DATA_WIDTH_PER_CHANNEL - 1);
                    else
                        Data_Left <= Data_Left((DATA_WIDTH_PER_CHANNEL - 2) downto 0) & '0';  
                        SOUT_Signal <= Data_Left(DATA_WIDTH_PER_CHANNEL - 1);
                    end if;   
                    
                    if(Ready_Signal = '1') then
                        Data_Left <= Data(((DATA_WIDTH_PER_CHANNEL * 2) - 1) downto DATA_WIDTH_PER_CHANNEL);
                        Data_Right <= Data((DATA_WIDTH_PER_CHANNEL - 1) downto 0);
                        Ready_Signal <= '0';
                    end if;    
                    
                    if(Counter = ((DATA_WIDTH_PER_CHANNEL * 2)) - 2) then
                        Ready_Signal <= '1'; 
                    end if;        
                end if;
            end if;
        end process;
        
        
ODDR_inst: 
        component ODDR generic map(
               DDR_CLK_EDGE => "OPPOSITE_EDGE",
               INIT => '0',
               SRTYPE => "SYNC")
        port map (
               Q => SCLK,
               C => I2S_Clock,
               CE => '1',
               D1 => '1',
               D2 => '0',
               R => Reset,
               S => '0'
            );    

    Tx_Interrupt <= Ready_Signal;
    LRCLK <= LRCLK_Signal;
    SOUT <= SOUT_Signal;

end architecture I2S_Transmitter_Arch;