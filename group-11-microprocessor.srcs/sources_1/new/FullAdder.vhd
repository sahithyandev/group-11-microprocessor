LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY FullAdder IS
    PORT (
        A : IN STD_LOGIC;
        B : IN STD_LOGIC;
        C_in : IN STD_LOGIC;
        S : OUT STD_LOGIC;
        C_out : OUT STD_LOGIC);
END FullAdder;

ARCHITECTURE Behavioral OF FullAdder IS
    COMPONENT HalfAdder
        PORT (
            A : IN STD_LOGIC;
            B : IN STD_LOGIC;
            S : OUT STD_LOGIC;
            C : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL HA0_S, HA0_C, HA1_S, HA1_C : STD_LOGIC;

BEGIN
    HA_0 : HalfAdder
    PORT MAP(
        A => A,
        B => B,
        S => HA0_S,
        C => HA0_C);

    HA_1 : HalfAdder
    PORT MAP(
        A => HA0_S,
        B => C_in,
        S => HA1_S,
        C => HA1_C);

    C_out <= HA0_C OR HA1_C;
    S <= HA1_S;

END Behavioral;