----------------------------------------------------------------------------------
-- Company: CSE_UOM
-- Engineer: Sheneth Fernando
-- Create Date: 05/04/2025 09:35:43 PM
-- Module Name: TB_Mux8x1_4Bit - Behavioral
 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_Mux8x1_4Bit is
--  Port ( );
end TB_Mux8x1_4Bit;

architecture Behavioral of TB_Mux8x1_4Bit is
component Mux8x1_4Bit
    Port (
        D0  : in  STD_LOGIC_VECTOR(3 downto 0);
        D1  : in  STD_LOGIC_VECTOR(3 downto 0);
        D2  : in  STD_LOGIC_VECTOR(3 downto 0);
        D3  : in  STD_LOGIC_VECTOR(3 downto 0);
        D4  : in  STD_LOGIC_VECTOR(3 downto 0);
        D5  : in  STD_LOGIC_VECTOR(3 downto 0);
        D6  : in  STD_LOGIC_VECTOR(3 downto 0);
        D7  : in  STD_LOGIC_VECTOR(3 downto 0);
        sel : in  STD_LOGIC_VECTOR(2 downto 0);
        en  : in  STD_LOGIC;
        Y   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end component;

signal D0, D1, D2, D3, D4, D5, D6, D7 : STD_LOGIC_VECTOR(3 downto 0);
signal sel : STD_LOGIC_VECTOR(2 downto 0);
signal en  : STD_LOGIC;
signal Y   : STD_LOGIC_VECTOR(3 downto 0);

begin
    UUT: Mux8x1_4Bit
    port map (
        D0 => D0, D1 => D1, D2 => D2, D3 => D3,
        D4 => D4, D5 => D5, D6 => D6, D7 => D7,
        sel => sel,
        en  => en,
        Y   => Y
    );
    
    process
    begin
    
    -- Initialize inputs
    D0 <= "0000"; D1 <= "0001"; D2 <= "0010"; D3 <= "0011";
    D4 <= "0100"; D5 <= "0101"; D6 <= "0110"; D7 <= "0111";

    en <= '1';

    -- Test each selector value with enable = 1
    for i in 0 to 7 loop
        sel <= std_logic_vector(to_unsigned(i, 3));
        -- When i=0, D0 is selected
        -- When i=1, D1 is selected
        -- When i=2, D2 is selected
        -- When i=3, D3 is selected
        -- When i=4, D4 is selected
        -- When i=5, D5 is selected
        -- When i=6, D6 is selected
        -- When i=7, D7 is selected
        wait for 100 ns;
    end loop;

    -- Disable enable signal
    en <= '0';
    for i in 0 to 7 loop
        sel <= std_logic_vector(to_unsigned(i, 3));
        --None of the inputs are selected when  en=0
        wait for 100 ns;
    end loop;

    wait;
end process;

end Behavioral;
