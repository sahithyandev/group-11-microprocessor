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
        "100010000011", --0: MOVI R1, 3 
        "101110000000", --1: MOVI R7, 0
        "001110010000", --2: ADD R7, R1
        "100100001111", --3: MOVI R2, -1
        "000010100000", --4: ADD R1, R2
        "110010000101", --5: JZR R1, 5
        "110000000010", --6: JZR R0, 2
        "000000000000" --7
    );

BEGIN
    instruction <= Program_ROM(to_integer(unsigned(address)));

END Behavioral;