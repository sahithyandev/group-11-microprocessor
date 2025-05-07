----------------------------------------------------------------------------------
-- Company: CSE_UOM
-- Engineer: Sheneth Fernando
-- Create Date: 05/04/2025 09:35:43 PM
-- Module Name: TB_Mux8x1_4Bit - Behavioral

----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY TB_Mux8x1_4Bit IS
    --  Port ( );
END TB_Mux8x1_4Bit;

ARCHITECTURE Behavioral OF TB_Mux8x1_4Bit IS
    COMPONENT Mux_4bit_8way
        PORT (
            D0 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            D1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            D2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            D3 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            D4 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            D5 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            D6 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            D7 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            sel : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            en : IN STD_LOGIC;
            Y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL D0, D1, D2, D3, D4, D5, D6, D7 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL sel : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL en : STD_LOGIC;
    SIGNAL Y : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
    UUT : Mux_4bit_8way
    PORT MAP(
        D0 => D0, D1 => D1, D2 => D2, D3 => D3,
        D4 => D4, D5 => D5, D6 => D6, D7 => D7,
        sel => sel,
        en => en,
        Y => Y
    );

    PROCESS
    BEGIN

        -- Initialize inputs
        D0 <= "0000";
        D1 <= "0001";
        D2 <= "0010";
        D3 <= "0011";
        D4 <= "0100";
        D5 <= "0101";
        D6 <= "0110";
        D7 <= "0111";

        en <= '1';

        -- Test each selector value with enable = 1
        FOR i IN 0 TO 7 LOOP
            sel <= STD_LOGIC_VECTOR(to_unsigned(i, 3));
            -- When i=0, D0 is selected
            -- When i=1, D1 is selected
            -- When i=2, D2 is selected
            -- When i=3, D3 is selected
            -- When i=4, D4 is selected
            -- When i=5, D5 is selected
            -- When i=6, D6 is selected
            -- When i=7, D7 is selected
            WAIT FOR 100 ns;
        END LOOP;

        -- Disable enable signal
        en <= '0';
        FOR i IN 0 TO 7 LOOP
            sel <= STD_LOGIC_VECTOR(to_unsigned(i, 3));
            --None of the inputs are selected when  en=0
            WAIT FOR 100 ns;
        END LOOP;

        WAIT;
    END PROCESS;

END Behavioral;