----------------------------------------------------------------------------------
-- Engineer: Sahithyan K.
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Mux_3bit_2way IS
    PORT (
        A : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        S : IN STD_LOGIC;
        Y : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END Mux_3bit_2way;

ARCHITECTURE Behavioral OF Mux_3bit_2way IS

BEGIN
    PROCESS (A, B, S)
    BEGIN
        IF S = '0' THEN
            Y <= A;
        ELSE
            Y <= B;
        END IF;
    END PROCESS;
END Behavioral;