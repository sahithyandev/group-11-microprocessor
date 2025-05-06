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
        "000000000000", -- 0
        "000000000000", --1
        "000000000000", --2
        "000000000000", --3
        "000000000000", --4
        "000000000000", --5
        "000000000000", --6
        "000000000000" --7
    );

BEGIN
    instruction <= Program_ROM(to_integer(unsigned(address)));

END Behavioral;