----------------------------------------------------------------------------------
-- Company:             www.kampis-elektroecke.de
-- Engineer:            Daniel Kampert
-- 
-- Create Date:         02.08.2014 13:17:51
-- Design Name: 
-- Module Name:         VGA - VGA_Arch
-- Project Name: 
-- Target Devices:      XC7Z010CLG400-1
-- Tool Versions:       Vivado 2014.4
-- Description:         VGA Interface for a 640 x 480 Pixel Screen
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity VGA is
    Generic (
            Color_Width         : integer := 16;                                        -- Breite Ausgabebus fuer die Farbe
            ROM_Address_Width   : integer := 11;                                        -- Breite Adressbus Font-ROM
            ROM_Data_Width      : integer := 8;                                         -- Breite Datenbus Font-ROM
            Char_Size           : integer := 8;                                         -- Breite eines Zeichens
            Max_Char_x          : integer := 80;                                        -- Maximale Anzahl Zeichen bezogen auf die Breite
            Max_Char_y          : integer := 60                                         -- Maximale Anzahl Zeichen bezogen auf die Hoehe
            );
    Port (  Clock_VGA   : in STD_LOGIC;                                                 -- Taktsignal fuer VGA-Logik
            Reset       : in STD_LOGIC;                                                 -- Reset fuer VGA-Logik
            Mode        : in STD_LOGIC;                                                 -- Auswahl Betriebsmodus, 0 -> Grafik, 1 -> Text
            Display_DataIn: in STD_LOGIC_VECTOR((Color_Width + Char_Size - 1) downto 0);  -- Daten zum Beschreiben des Display-RAMs
            Display_Addr: in STD_LOGIC_VECTOR(12 downto 0);                             -- Adresse zum Beschreiben des Display-RAMs
            HSync       : out STD_LOGIC;                                                -- Ausgang for H-Sync Signal
            VSync       : out STD_LOGIC;                                                -- Ausgang fuer V-Sync Signal
            RGB         : out STD_LOGIC_VECTOR((Color_Width - 1) downto 0)              -- RGB Ausgang fuer das VGA-Signal
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

    constant Sync_Delay         : integer := 5;
    signal HSync_Delay          : std_logic;
    signal VSync_Delay          : std_logic;
    signal HSync_Delay_Line     : std_logic_vector((Sync_Delay - 1) downto 0);
    signal VSync_Delay_Line     : std_logic_vector((Sync_Delay - 1) downto 0);

    -- Font ROM
    signal ROM_Data             : std_logic_vector(0 to (ROM_Data_Width - 1));
    signal ROM_Address          : std_logic_vector(0 to (ROM_Address_Width - 1));
    signal ROM_Bit              : std_logic_vector(1 downto 0);
    signal Row_Addr             : std_logic_vector(2 downto 0);
    signal Col_Addr             : std_logic_vector(2 downto 0);

    -- Display RAM
    signal Display_Read_Address : unsigned(12 downto 0) := (others => '0');
    signal CharAddress          : unsigned(6 downto 0);
    signal Offset               : unsigned(12 downto 0) := (others => '0');
    signal DisplayRAMOut        : std_logic_vector((Color_Width + Char_Size - 1) downto 0);
    signal DisplayCharacter     : std_logic_vector((Char_Size - 1) downto 0); 
    signal Color                : std_logic_vector((Color_Width - 1) downto 0);

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

    -- Font-ROM fuer VGA-Controller
    component Font_ROM is
        port (  ROM_Address : in STD_LOGIC_VECTOR((ROM_Address_Width - 1) downto 0);
                ROM_Clock   : in STD_LOGIC;
                ROM_DataOut : out STD_LOGIC_VECTOR((ROM_Data_Width - 1) downto 0)
                );
    end component Font_ROM;
    
    -- Display-RAM fuer den aktuellen Displayinhalt
    component Display_RAM is
        port (  Display_Write_Addr : in STD_LOGIC_VECTOR ( 12 downto 0 );
                Display_Clock_Write : in STD_LOGIC;
                Display_Data_In : in STD_LOGIC_VECTOR ( 23 downto 0 );
                Display_Read_Write : in STD_LOGIC_VECTOR ( 0 to 0 );
                Display_Read_Addr : in STD_LOGIC_VECTOR ( 12 downto 0 );
                Display_Clock_Read : in STD_LOGIC;
                Display_Data_Out : out STD_LOGIC_VECTOR ( 23 downto 0 )
                );
    end component;

begin

    VGA_Ctrl        : VGA_Timing port map (HSync_Delay, VSync_Delay, Clock_VGA, Reset, Pixel_x_delay_0, Pixel_y_delay_0);   
    Char_Font       : Font_ROM port map (   ROM_Address => ROM_Address, 
                                            ROM_Clock => Clock_VGA,
                                            ROM_DataOut => ROM_Data);
    Display         : Display_RAM port map (Display_Clock_Write => Clock_VGA, 
                                            Display_Clock_Read => Clock_VGA, 
                                            Display_Data_In => Display_DataIn, 
                                            Display_Data_Out => DisplayRAMOut, 
                                            Display_Read_Addr => std_logic_vector(Display_Read_Address), 
                                            Display_Write_Addr => Display_Addr,
                                            Display_Read_Write => "1"); 
    
    --Farbausgabe 
    RGB <= Color when (ROM_Bit(1) = '1') else x"0000";   

    -- Farbe und Zeichen trennen
    DisplayCharacter   <= DisplayRAMOut((Char_Size - 1) downto 0);
    Color       <= DisplayRAMOut((Color_Width + Char_Size - 1) downto Char_Size);

    -- ROM auslesen
    Row_Addr    <= std_logic_vector(Pixel_y_delay_3(2 downto 0));
    ROM_Address <= DisplayCharacter & Row_Addr;
    Col_Addr    <= std_logic_vector(Pixel_x_delay_3(2 downto 0));
    ROM_Bit(0)  <= ROM_Data(to_integer(unsigned(Col_Addr)));     

    -- Adresse fuer Display-RAM erzeugen
    CharAddress <= Pixel_x_delay_0(9 downto 3);   
    Display_Read_Address <= Offset + CharAddress; 

    process(Clock_VGA)
    begin 
        if(rising_edge(Clock_VGA)) then  
            if(Pixel_x_delay_0(2 downto 0) = "000") then
                if((Pixel_x_delay_0 = 640) and (Pixel_y_delay_0 = 480)) then
                    Offset <= to_unsigned(0, Offset'length);
                elsif((Pixel_x_delay_0 = 0) and (Pixel_y_delay_0(2 downto 0) = 0)) then 
                    Offset <= Offset + Max_Char_x; 
                end if;        
            end if;   
        end if;
     end process;

    -- Signale verzoegern
    HSync <= HSync_Delay_Line(Sync_Delay - 1);
    VSync <= VSync_Delay_Line(Sync_Delay - 1);  
    
    process(Clock_VGA)
    begin
        if(rising_edge(Clock_VGA)) then
            HSync_Delay_Line <= HSync_Delay_Line((HSync_Delay_Line'length - 2) downto 0) & HSync_Delay;
            VSync_Delay_Line <= VSync_Delay_Line((VSync_Delay_Line'length - 2) downto 0) & VSync_Delay;

            Pixel_x_delay_1 <= Pixel_x_delay_0;
            Pixel_y_delay_1 <= Pixel_y_delay_0;
            Pixel_x_delay_2 <= Pixel_x_delay_1;
            Pixel_y_delay_2 <= Pixel_y_delay_1;
            Pixel_x_delay_3 <= Pixel_x_delay_2;
            Pixel_y_delay_3 <= Pixel_y_delay_2;
            
            ROM_Bit(1) <= ROM_Bit(0);
            
        end if;
    end process;
end VGA_Arch;