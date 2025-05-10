LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ROM IS
    PORT (
        address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        instruction : OUT STD_LOGIC_VECTOR (11 DOWNTO 0));
END ROM;

ARCHITECTURE Behavioral OF ROM IS
    TYPE rom_type IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(11 DOWNTO 0);

    SIGNAL Program_ROM : rom_type := (
        "100010001010", --0: MOVI R1, 10 
        "100100000001", --1: MOVI R2, 1
        "010100100000", --2: NEG R2
        "000010100000", --3: ADD R1, R2
        "110010000111", --4: JZR R1, 7
        "110000000010", --5: JZR R0, 3
        "000000000000", --6
        "000000000000"  --7
    );

BEGIN
    instruction <= Program_ROM(to_integer(unsigned(address)));

END Behavioral;