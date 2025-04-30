LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Decoder_3_to_8 IS
    PORT (
        I : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        EN : IN STD_LOGIC;
        Y : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END Decoder_3_to_8;

ARCHITECTURE Behavioral OF Decoder_3_to_8 IS
    COMPONENT Decoder_2_to_4
        PORT (
            I : IN STD_LOGIC_VECTOR;
            EN : IN STD_LOGIC;
            Y : OUT STD_LOGIC_VECTOR);
    END COMPONENT;
    SIGNAL IA, IB : STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL YA, YB : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL ENA, ENB, I2 : STD_LOGIC;

BEGIN

    Decoder_2_to_4_A : Decoder_2_to_4
    PORT MAP(
        I => IA,
        EN => ENA,
        Y => YA);
    Decoder_2_to_4_B : Decoder_2_to_4
    PORT MAP(
        I => IB,
        EN => ENB,
        Y => YB);

    ENA <= NOT(I(2)) AND EN;
    ENB <= I(2) AND EN;

    IA <= I(1 DOWNTO 0);
    IB <= I(1 DOWNTO 0);

    I2 <= I(2);

    Y(3 DOWNTO 0) <= YA;
    Y(7 DOWNTO 4) <= YB;

END Behavioral;