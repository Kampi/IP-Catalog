----------------------------------------------------------------------------------
-- Company:             www.kampis-elektroecke.de
-- Engineer:            Daniel Kampert
-- 
-- Create Date:         02.08.2014 13:17:51
-- Design Name: 
-- Module Name:         VGA - VGA_Arch
-- Project Name: 
-- Target Devices:      XC7Z010CLG400-1
-- Tool Versions:       Vivado 2016.4
-- Description:         VGA Interface for a 640 x 480 Pixel Screen
-- 
-- Dependencies: 
-- 
-- Revision             0.0.1   - File Created
--                      1.0.0   - Initial release
--                      2.0.0   - Fix some bugs
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity VGA is
    Generic (
            COLOR               : integer := 16;                                        -- Breite Ausgabebus arbe
            ROM_Address_Width   : integer := 11;                                        -- Breite Adressbus Font-ROM
            ROM_Data_Width      : integer := 8;                                         -- Breite Datenbus Font-ROM
            Char_Size           : integer := 8;                                         -- Breite eines Zeichens
            Max_Char_x          : integer := 80;                                        -- Maximale Anzahl Zeichen bezogen auf die Breite
            Max_Char_y          : integer := 60                                         -- Maximale Anzahl Zeichen bezogen auf die Höhe
            );
    Port (  Clock_VGA   : in STD_LOGIC;                                                 -- Taktsignal für VGA-Logik
            Reset       : in STD_LOGIC;                                                 -- Reset für VGA-Logik
            Mode        : in STD_LOGIC;                                                 -- Auswahl Betriebsmodus, 0 -> Grafik, 1 -> Text
            Read_Write  : in STD_LOGIC;                                                 -- Lesen oder Schreiben aus Display RAM, 0 -> Schreiben, 1 -> Lesen
            Display_Data: in STD_LOGIC_VECTOR((COLOR + Char_Size - 1) downto 0);        -- Daten zum Beschreiben des Display-RAMs
            Display_Addr: in UNSIGNED(12 downto 0);                                     -- Adresse für Display-RAM
            HSync       : out STD_LOGIC;                                                -- Ausgang für H-Sync Signal
            VSync       : out STD_LOGIC;                                                -- Ausgang für V-Sync Signal
            RGB         : out STD_LOGIC_VECTOR((COLOR - 1) downto 0)                    -- RGB Ausgang für das VGA-Signal
            );
end VGA;

architecture VGA_Arch of VGA is

    -- Koordinaten des Zeigers auf dem Bildschirm
    signal Pixel_x_delay_0      : unsigned(9 downto 0);               
    signal Pixel_y_delay_0      : unsigned(9 downto 0); 
    signal Pixel_x_delay_1      : unsigned(9 downto 0);               
    signal Pixel_y_delay_1      : unsigned(9 downto 0); 
    signal Pixel_x_delay_2      : unsigned(9 downto 0);               
    signal Pixel_y_delay_2      : unsigned(9 downto 0); 
    signal Pixel_x_delay_3      : unsigned(9 downto 0);               
    signal Pixel_y_delay_3      : unsigned(9 downto 0); 

    signal HSync_delay_0        : std_logic;
    signal VSync_delay_0        : std_logic;
    signal HSync_delay_1        : std_logic;
    signal VSync_delay_1        : std_logic; 
    signal HSync_delay_2        : std_logic;
    signal VSync_delay_2        : std_logic; 
    signal HSync_delay_3        : std_logic;
    signal VSync_delay_3        : std_logic; 
    signal HSync_delay_4        : std_logic;
    signal VSync_delay_4        : std_logic; 

    -- Font ROM
    signal ROM_Data             : std_logic_vector(0 to (ROM_Data_Width - 1));
    signal ROM_Address          : std_logic_vector(0 to (ROM_Address_Width - 1));
    signal ROM_Bit              : std_logic;
    signal Row_Addr             : std_logic_vector(2 downto 0);
    signal Col_Addr             : std_logic_vector(2 downto 0);

    -- Display RAM
    signal Display_Address      : unsigned(12 downto 0) := (others => '0');
    signal Zeichen_Address      : unsigned(6 downto 0);
    signal Offset               : unsigned(12 downto 0) := (others => '0');
    signal Display_Buffer       : std_logic_vector((COLOR + Char_Size - 1) downto 0);
    signal Character_Vector     : std_logic_vector((Char_Size - 1) downto 0); 
    signal Color_Vector         : std_logic_vector((COLOR - 1) downto 0);

    -- Einbinden des VGA-Controllers
    component VGA_Timing is
        Port (  HSync       : out STD_LOGIC;
                VSync       : out STD_LOGIC;
                Clock_VGA   : in STD_LOGIC;
                Reset       : in STD_LOGIC;
                x_out       : out UNSIGNED(9 downto 0);                
                y_out       : out UNSIGNED(9 downto 0) 
                );
    end component VGA_Timing;  

    -- Font-ROM für VGA-Controller
    component Font_ROM is
        port (  ROM_Address : in STD_LOGIC_VECTOR((ROM_Address_Width - 1) downto 0);
                ROM_Clock   : in STD_LOGIC;
                ROM_DataOut : out STD_LOGIC_VECTOR((ROM_Data_Width - 1) downto 0)
                );
    end component Font_ROM;

    -- Display RAM für das Bild    
    component Display_RAM
        Generic (
                Addr_Width : integer := 13;
                Data_Width : integer := 24
                );
        Port (  Display_Clock_Read : in STD_LOGIC;
                Display_Clock_Write: in STD_LOGIC;   
                Display_Read_Write  : in STD_LOGIC;
                Display_Read_Addr   : in UNSIGNED((Addr_Width - 1) downto 0);
                Display_Write_Addr  : in UNSIGNED((Addr_Width - 1) downto 0);
                Display_Data_Out    : out STD_LOGIC_VECTOR ((Data_Width - 1) downto 0);
                Display_Data_In     : in STD_LOGIC_VECTOR ((Data_Width - 1) downto 0)
                );
    end component;

begin

    HSync <= HSync_delay_4;
    VSync <= VSync_delay_4;

    VGA_Ctrl        : VGA_Timing port map ( HSync => HSync_delay_0, 
                                            VSync => VSync_delay_0, 
                                            Clock_VGA => Clock_VGA, 
                                            Reset => Reset,
                                            x_out => Pixel_x_delay_0, 
                                            y_out => Pixel_y_delay_0
                                            );

    Char_Font       : Font_ROM port map (   ROM_Address => ROM_Address, 
                                            ROM_Clock => Clock_VGA, 
                                            ROM_DataOut => ROM_Data
                                            );
 
    Display         : Display_RAM port map (Display_Clock_Read => Clock_VGA,
                                            Display_Clock_Write => Clock_VGA,
                                            Display_Read_Write => Read_Write, 
                                            Display_Read_Addr => Display_Address, 
                                            Display_Write_Addr => Display_Address, 
                                            Display_Data_Out => Display_Buffer,
                                            Display_Data_In => Display_Data
                                            ); 
    
    --Farbausgabe    
    process(Clock_VGA)
    begin
        if(rising_edge(Clock_VGA)) then
            if(Read_Write = '1') then 
                if((ROM_Bit = '1')) then
                    RGB <= Color_Vector;
                else
                    RGB <= x"0000";
                end if;              
            end if;                    
        end if;
    end process;

    -- Farbe und Zeichen trennen
    Character_Vector   <= Display_Buffer((Char_Size - 1) downto 0);
    Color_Vector       <= Display_Buffer((COLOR + Char_Size - 1) downto Char_Size);

    -- ROM auslesen
    Row_Addr    <= std_logic_vector(Pixel_y_delay_2(2 downto 0));
    ROM_Address <= Character_Vector & Row_Addr;
    Col_Addr    <= std_logic_vector(Pixel_x_delay_2(2 downto 0));
    ROM_Bit     <= ROM_Data(to_integer(unsigned(Col_Addr)));     

    Zeichen_Address <= Pixel_x_delay_0(9 downto 3);   
    Display_Address <= (Offset + Zeichen_Address) when (Read_Write = '1') else Display_Addr; 

    process(Clock_VGA)
    begin 
        if(rising_edge(Clock_VGA)) then  
            if(Read_Write = '1') then
                if(Pixel_x_delay_0(2 downto 0) = "000") then
                    if((Pixel_x_delay_0 = 0) and (Pixel_y_delay_0 = 0)) then
                        Offset <= to_unsigned(0, Offset'length);
                    elsif((Pixel_x_delay_0 = 0) and (Pixel_y_delay_0(2 downto 0) = 0)) then 
                        Offset <= Offset + Max_Char_x; 
                    end if;        
                end if;   
            end if;   
        end if;
     end process;

    -- Signale um einen Takt verzögern
    process(Clock_VGA)
    begin
        if(rising_edge(Clock_VGA)) then
            HSync_delay_1 <= HSync_delay_0;
            VSync_delay_1 <= VSync_delay_0;
            HSync_delay_2 <= HSync_delay_1;
            VSync_delay_2 <= VSync_delay_1;
            HSync_delay_3 <= HSync_delay_2;
            VSync_delay_3 <= VSync_delay_2;
            HSync_delay_4 <= HSync_delay_3;
            VSync_delay_4 <= VSync_delay_3;

            Pixel_x_delay_1 <= Pixel_x_delay_0;
            Pixel_y_delay_1 <= Pixel_y_delay_0;
            Pixel_x_delay_2 <= Pixel_x_delay_1;
            Pixel_y_delay_2 <= Pixel_y_delay_1;
            Pixel_x_delay_3 <= Pixel_x_delay_2;
            Pixel_y_delay_3 <= Pixel_y_delay_2;
        end if;
    end process;

end VGA_Arch;