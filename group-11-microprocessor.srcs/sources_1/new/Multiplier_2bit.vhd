LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Multiplier_2 IS
    PORT (
        a : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        b : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        C_in : IN STD_LOGIC);
END Multiplier_2;

ARCHITECTURE Behavioral OF Multiplier_2 IS
    COMPONENT FullAdder
        PORT (
            A : IN STD_LOGIC;
            B : IN STD_LOGIC;
            C_in : IN STD_LOGIC;
            S : OUT STD_LOGIC;
            C_out : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL A0B0, A1B0, A1B1, A0B1 : STD_LOGIC;
    SIGNAL C1 : STD_LOGIC;

BEGIN

    A0B0 <= A(0) AND B(0);
    A1B0 <= A(1) AND B(0);
    A1B1 <= A(1) AND B(1);
    A0B1 <= A(0) AND B(1);

    FA_0 : FullAdder
    PORT MAP(
        A => A1B0,
        B => A0B1,
        C_in => C_in,
        S => Y(1),
        C_Out => C1);

    FA_1 : FullAdder
    PORT MAP(
        A => '0',
        B => A1B1,
        C_in => C1,
        S => Y(2),
        C_Out => Y(3));

    Y(0) <= A0B0;

END Behavioral;