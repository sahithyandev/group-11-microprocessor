LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_misc.OR_REDUCE;

ENTITY Mux_8_to_1 IS
    PORT (
        S : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        D : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        EN : IN STD_LOGIC;
        Y : OUT STD_LOGIC);
END Mux_8_to_1;

ARCHITECTURE Behavioral OF Mux_8_to_1 IS

    COMPONENT Decoder_3_to_8
        PORT (
            I : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            EN : IN STD_LOGIC;
            Y : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
    END COMPONENT;

    SIGNAL YO : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL AND_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

    Decoder_3_to_8_A : Decoder_3_to_8
    PORT MAP(
        I => S,
        EN => EN,
        Y => YO);

    AND_OUT <= D AND YO;
    Y <= OR_REDUCE(AND_OUT);

END Behavioral;