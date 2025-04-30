LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Reg IS
    PORT (
        D : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        En : IN STD_LOGIC;
        Clk : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END Reg;

ARCHITECTURE Behavioral OF Reg IS

BEGIN
    PROCESS (Clk) BEGIN
        IF (rising_edge(Clk)) THEN
            IF En = '1' THEN
                Q <= D;
            END IF;
        END IF;
    END PROCESS;

END Behavioral;