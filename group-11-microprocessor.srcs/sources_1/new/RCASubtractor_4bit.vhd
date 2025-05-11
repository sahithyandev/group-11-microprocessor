LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_MISC.OR_REDUCE;

ENTITY RCASubtractor_4bit IS
    PORT (
        A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        SUB : IN STD_LOGIC; -- 0 for Add, 1 for Subtract
        S : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Overflow : OUT STD_LOGIC;
        Zero : OUT STD_LOGIC
    );
END RCASubtractor_4bit;

ARCHITECTURE Behavioral OF RCASubtractor_4bit IS

    COMPONENT FullAdder
        PORT (
            A : IN STD_LOGIC;
            B : IN STD_LOGIC;
            C_in : IN STD_LOGIC;
            S : OUT STD_LOGIC;
            C_out : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL B_xor : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL C : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Final_Cout : STD_LOGIC;
    SIGNAL Result : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
    -- XOR B with SUB for 2's complement subtraction
    B_xor <= B XOR (SUB & SUB & SUB & SUB); -- Vectorized version

    -- Instantiate 4 full adders
    FA0 : FullAdder PORT MAP(A => A(0), B => B_xor(0), C_in => SUB, S => Result(0), C_out => C(0));
    FA1 : FullAdder PORT MAP(A => A(1), B => B_xor(1), C_in => C(0), S => Result(1), C_out => C(1));
    FA2 : FullAdder PORT MAP(A => A(2), B => B_xor(2), C_in => C(1), S => Result(2), C_out => C(2));
    FA3 : FullAdder PORT MAP(A => A(3), B => B_xor(3), C_in => C(2), S => Result(3), C_out => Final_Cout);

    -- Assign final result to output
    S <= Result;

    -- Overflow detection: XOR of last two carry bits
    Overflow <= C(2) XOR Final_Cout;

    Zero <= NOT(OR_REDUCE(Result));

END Behavioral;