LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY Multiplier_4 IS
    PORT (
        a : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        b : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END Multiplier_4;

ARCHITECTURE Behavioral OF Multiplier_4 IS
    COMPONENT FA
        PORT (
            A : IN STD_LOGIC;
            B : IN STD_LOGIC;
            C_in : IN STD_LOGIC;
            S : OUT STD_LOGIC;
            C_out : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL A0B0, A1B0, A0B1, A2B0, A1B1, A0B2, A3B0, A2B1, A1B2, A0B3, A3B1, A2B2, A1B3, A3B2, A2B3, A3B3 : STD_LOGIC;
    SIGNAL C : STD_LOGIC_VECTOR(10 DOWNTO 0);
    SIGNAL I : STD_LOGIC_VECTOR(5 DOWNTO 0);

BEGIN
    A0B0 <= A(0) AND B(0);
    A1B0 <= A(1) AND B(0);
    A2B0 <= A(2) AND B(0);
    A3B0 <= A(3) AND B(0);
    A0B1 <= A(0) AND B(1);
    A1B1 <= A(1) AND B(1);
    A2B1 <= A(2) AND B(1);
    A3B1 <= A(3) AND B(1);
    A0B2 <= A(0) AND B(2);
    A1B2 <= A(1) AND B(2);
    A2B2 <= A(2) AND B(2);
    A3B2 <= A(3) AND B(2);
    A0B3 <= A(0) AND B(3);
    A1B3 <= A(1) AND B(3);
    A2B3 <= A(2) AND B(3);
    A3B3 <= A(3) AND B(3);
    Y(0) <= A0B0;

    FA_0 : FA PORT MAP(A => A1B0, B => A0B1, C_in => '0', S => Y(1), C_out => C(0));

    FA_1_0 : FA PORT MAP(A => A2B0, B => A1B1, C_in => C(0), S => I(0), C_out => C(1));
    FA_1_1 : FA PORT MAP(A => I(0), B => A0B2, C_in => '0', S => Y(2), C_out => C(2));

    FA_2_0 : FA PORT MAP(A => A3B0, B => A2B1, C_in => C(1), S => I(1), C_out => C(3));
    FA_2_1 : FA PORT MAP(A => I(1), B => A1B2, C_in => C(2), S => I(2), C_out => C(4));
    FA_2_2 : FA PORT MAP(A => I(2), B => A0B3, C_in => '0', S => Y(3), C_out => C(7));

    FA_3_0 : FA PORT MAP(A => A3B1, B => A2B2, C_in => C(3), S => I(3), C_out => C(5));
    FA_3_1 : FA PORT MAP(A => I(3), B => A1B3, C_in => C(4), S => I(4), C_out => C(6));
    FA_3_2 : FA PORT MAP(A => I(4), B => C(7), C_in => '0', S => Y(4), C_out => C(8));

    FA_4_0 : FA PORT MAP(A => A3B2, B => A2B3, C_in => C(5), S => I(5), C_out => C(9));
    FA_4_1 : FA PORT MAP(A => I(5), B => C(8), C_in => C(6), S => Y(5), C_out => C(10));

    FA_5 : FA PORT MAP(A => A3B3, B => C(9), C_in => C(10), S => Y(6), C_out => Y(7));

END Behavioral;