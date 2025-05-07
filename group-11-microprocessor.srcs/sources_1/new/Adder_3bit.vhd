LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Adder_3bit IS
    PORT (
        PC : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Next_PC : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        PC_Carry : OUT STD_LOGIC
    );
END Adder_3bit;

ARCHITECTURE Behavioral OF Adder_3bit IS

    COMPONENT FullAdder
        PORT (
            A : IN STD_LOGIC;
            B : IN STD_LOGIC;
            C_in : IN STD_LOGIC;
            S : OUT STD_LOGIC;
            C_out : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL C1, C2 : STD_LOGIC;

BEGIN

    -- Bit 0: PC(0) + 1
    FA0 : FullAdder PORT MAP(
        A => PC(0),
        B => '1',
        C_in => '0',
        S => Next_PC(0),
        C_out => C1
    );

    -- Bit 1: PC(1) + carry from bit 0
    FA1 : FullAdder PORT MAP(
        A => PC(1),
        B => '0',
        C_in => C1,
        S => Next_PC(1),
        C_out => C2
    );

    -- Bit 2: PC(2) + carry from bit 1
    FA2 : FullAdder PORT MAP(
        A => PC(2),
        B => '0',
        C_in => C2,
        S => Next_PC(2),
        C_out => PC_Carry
    );

END Behavioral;