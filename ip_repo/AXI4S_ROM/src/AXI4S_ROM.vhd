----------------------------------------------------------------------------------
-- Company:             www.kampis-elektroecke.de
-- Engineer:            Daniel Kampert  
-- 
-- Create Date:         18.07.2019 08:26:24
-- Design Name: 
-- Module Name:         AXI4S_ROM - AXI4S_ROM_Arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description:         Simple ROM with am AXI4 stream master interface. 
-- 
-- Dependencies: 
-- 
-- Revision:
--      Revision 0.01 - File Created
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

entity AXI4S_ROM is
    Port ( ACLK     : in STD_LOGIC;
           ARESETN  : in STD_LOGIC;
           
           -- AXI4S interface
           TDATA    : out STD_LOGIC_VECTOR(15 downto 0);
           TID      : out STD_LOGIC_VECTOR(7 downto 0);
           TREADY   : in STD_LOGIC;
           TVALID   : out STD_LOGIC;
           TLAST    : out STD_LOGIC
           );
end AXI4S_ROM;

architecture AXI4S_ROM_Arch of AXI4S_ROM is

    type STATE_t is (Reset, EndOfReset, WaitForReady, SetData, WaitForHandShake);
    signal CurrentState : STATE_t := Reset;

    signal Address      : INTEGER := 0;

    signal ROM_Address  : STD_LOGIC_VECTOR(10 downto 0) := (others => '0');
    signal ROM_Data     : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal DataBuffer   : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

    component ROM is
        Port (  Address : in STD_LOGIC_VECTOR(10 downto 0);
                Clock : in STD_LOGIC;
                DataOut : out STD_LOGIC_VECTOR(15 downto 0)
                );
    end component;

begin

    DataROM : ROM port map (Address => ROM_Address,
                            DataOut => ROM_Data,
                            Clock => ACLK
                            );

    process(ACLK, ARESETN, TREADY, DataBuffer, CurrentState, Address)
    begin
        if(rising_edge(ACLK)) then
            case CurrentState is

                when Reset =>
                    TVALID <= '0';
                    Address <= 0;

                    if      ARESETN = '1' then CurrentState <= EndOfReset;
                    elsif   ARESETN = '0' then CurrentState <= Reset;
                    end if;

                when EndOfReset =>
                    CurrentState <= WaitForReady;

                when WaitForReady =>
                    TVALID <= '0';
                    DataBuffer <= ROM_Data;

                    -- Wait until TREADY from the slave
                    if      TREADY = '1' then CurrentState <= WaitForReady;
                    else    CurrentState <= SetData;
                    end if;
                    
                when SetData =>
                    TVALID <= '1';
                    TDATA <= DataBuffer;
                    TID <= STD_LOGIC_VECTOR(to_unsigned(Address, 8));
                    
                    -- Set TLAST to indicate the end of the package
                    if      Address = 99 then TLAST <= '1';
                    else    TLAST <= '0';
                    end if;

                    -- Reset the address counter if the end is reached
                    if      Address < 99 then Address <= Address + 1;
                    else    Address <= 0;
                    end if;
                    
                    CurrentState <= WaitForHandShake;

                when WaitForHandShake =>
                    
                    -- Wait until the slave has handshaked the data, signaled by pulling TREADY high
                    if      TREADY = '1' then CurrentState <= WaitForReady;
                                              TVALID <= '0';
                    end if;

            end case;
        end if;
    end process;

    ROM_Address <= STD_LOGIC_VECTOR(to_unsigned(Address, ROM_Address'length));

end AXI4S_ROM_Arch;