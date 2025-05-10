----------------------------------------------------------------------------------
-- Engineer: Sahithyan K.
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY PC_3bit IS
    PORT (
        Clk : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Enable : IN STD_LOGIC;
        Load : IN STD_LOGIC;
        Load_value : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        PC_out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END PC_3bit;

ARCHITECTURE Behavioral OF PC_3bit IS

    SIGNAL PC : unsigned(2 DOWNTO 0) := (OTHERS => '0');

BEGIN
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF Reset = '1' THEN
                PC <= (OTHERS => '0');
            ELSIF Load = '1' THEN
                PC <= unsigned(Load_value);
            ELSIF Enable = '1' AND PC < 7 THEN
                PC <= PC + 1;
            END IF;
        END IF;
    END PROCESS;

    PC_out <= STD_LOGIC_VECTOR(PC);

END Behavioral;