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
    
    signal TLAST_Int    : STD_LOGIC := '0';
    signal TVALID_Int   : STD_LOGIC := '0';

    signal TID_Int      : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal TDATA_Int    : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal ROM_Address  : STD_LOGIC_VECTOR(10 downto 0) := (others => '0');
    signal ROM_Data     : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal DataBuffer   : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

    component ROM_blk_mem_gen_0_0 is
        Port (  clka : in STD_LOGIC;
                addra : in STD_LOGIC_VECTOR(10 downto 0);
                douta : out STD_LOGIC_VECTOR(15 downto 0)
                );
    end component;

begin

    DataROM : ROM_blk_mem_gen_0_0 port map (addra => ROM_Address,
                                            douta => ROM_Data,
                                            clka => ACLK
                                            );

    process(ACLK, ARESETN, TREADY, DataBuffer, CurrentState, Address)
    begin
        if(rising_edge(ACLK)) then
            case CurrentState is

                when Reset =>
                    TVALID_Int <= '0';
                    TLAST_Int <= '0';
                    TDATA_Int <= (others => '0');
                    TID_Int <= (others => '0');
                    Address <= 0;

                    if      ARESETN = '1' then CurrentState <= EndOfReset;
                    elsif   ARESETN = '0' then CurrentState <= Reset;
                    end if;

                when EndOfReset =>
                    CurrentState <= WaitForReady;

                when WaitForReady =>
                    TVALID_Int <= '0';
                    DataBuffer <= ROM_Data;

                    -- Wait until TREADY from the slave
                    if      TREADY = '1' then CurrentState <= WaitForReady;
                    else    CurrentState <= SetData;
                    end if;
                    
                when SetData =>
                    TVALID_Int <= '1';
                    TDATA_Int <= DataBuffer;
                    TID_Int <= STD_LOGIC_VECTOR(to_unsigned(Address, 8));
                    
                    -- Reset the address counter if the end is reached and set TLAST to indicate the end of the package
                    if      Address = 99 then TLAST_Int <= '1';  
                                              Address <= 0;
                    else    TLAST_Int <= '0';
                            Address <= Address + 1;
                    end if;
                    
                    CurrentState <= WaitForHandShake;

                when WaitForHandShake =>
                    
                    -- Wait until the slave has handshaked the data, signaled by pulling TREADY high
                    if      TREADY = '1' then CurrentState <= WaitForReady;
                                              TVALID_Int <= '0';
                    end if;

            end case;
        end if;
    end process;

    TDATA <= TDATA_Int;
    TLAST <= TLAST_Int;
    TID <= TID_Int;
    TVALID <= TVALID_Int;
    ROM_Address <= STD_LOGIC_VECTOR(to_unsigned(Address, ROM_Address'length));

end AXI4S_ROM_Arch;