LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Adder_Subtractor_4bit IS
    PORT (
        A        : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        B        : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        SUB      : IN  STD_LOGIC;  -- 0 for Add, 1 for Subtract
        S        : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        C_out    : OUT STD_LOGIC;
        Overflow : OUT STD_LOGIC
    );
END Adder_Subtractor_4bit;

ARCHITECTURE Behavioral OF Adder_Subtractor_4bit IS

    COMPONENT FA
        PORT (
            A     : IN  STD_LOGIC;
            B     : IN  STD_LOGIC;
            C_in  : IN  STD_LOGIC;
            S     : OUT STD_LOGIC;
            C_out : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL B_xor : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL C     : STD_LOGIC_VECTOR(2 DOWNTO 0);

    SIGNAL Final_Cout : STD_LOGIC;

BEGIN
    -- XOR B with SUB for 2's complement subtraction
    B_xor(0) <= B(0) XOR SUB;
    B_xor(1) <= B(1) XOR SUB;
    B_xor(2) <= B(2) XOR SUB;
    B_xor(3) <= B(3) XOR SUB;

    -- Instantiate 4 full adders
    FA0 : FA PORT MAP(A => A(0), B => B_xor(0), C_in => SUB,     S => S(0), C_out => C(0));
    FA1 : FA PORT MAP(A => A(1), B => B_xor(1), C_in => C(0),    S => S(1), C_out => C(1));
    FA2 : FA PORT MAP(A => A(2), B => B_xor(2), C_in => C(1),    S => S(2), C_out => C(2));
    FA3 : FA PORT MAP(A => A(3), B => B_xor(3), C_in => C(2),    S => S(3), C_out => Final_Cout);

    C_out <= Final_Cout;

    -- Overflow detection: XOR of last two carry bits
    Overflow <= C(2) XOR Final_Cout;

END Behavioral;
