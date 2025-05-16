----------------------------------------------------------------------------------
-- Engineer: Sahithyan K.
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY PC_3bit IS
    PORT (
        Clk : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Load_value : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        PC_out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END PC_3bit;

ARCHITECTURE Behavioral OF PC_3bit IS

BEGIN
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF Reset = '1' THEN
                PC_out <= "000";
            ELSE
                PC_out <= Load_value;
            END IF;
        END IF;
    END PROCESS;
END Behavioral;