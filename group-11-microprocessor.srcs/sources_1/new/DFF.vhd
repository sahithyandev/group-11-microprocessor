LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY DFF IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        d : IN STD_LOGIC;
        q : OUT STD_LOGIC
    );
END DFF;

ARCHITECTURE Behavioral OF DFF IS
BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            q <= '0';
        ELSIF rising_edge(clk) THEN
            q <= d;
        END IF;
    END PROCESS;
END Behavioral;