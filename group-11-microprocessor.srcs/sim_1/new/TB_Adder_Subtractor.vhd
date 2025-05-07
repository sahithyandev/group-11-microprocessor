LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TB_Adder_Subtractor IS
END TB_Adder_Subtractor;

ARCHITECTURE Behavioral OF TB_Adder_Subtractor IS

    -- Component Declaration
    COMPONENT RCASubtractor_4bit
        PORT (
            A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            SUB : IN STD_LOGIC;
            S : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            C_out : OUT STD_LOGIC;
            Overflow : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Signals for inputs and outputs
    SIGNAL A, B : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL SUB : STD_LOGIC := '0';
    SIGNAL S : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL C_out : STD_LOGIC;
    SIGNAL Overflow : STD_LOGIC;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut : RCASubtractor_4bit
    PORT MAP(
        A => A,
        B => B,
        SUB => SUB,
        S => S,
        C_out => C_out,
        Overflow => Overflow
    );

    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        -- Test Case 1: 5 + 3 = 8
        A <= "0101"; -- 5
        B <= "0011"; -- 3
        SUB <= '0'; -- Addition
        WAIT FOR 10 ns;

        -- Test Case 2: 7 - 2 = 5
        A <= "0111"; -- 7
        B <= "0010"; -- 2
        SUB <= '1'; -- Subtraction
        WAIT FOR 10 ns;

        -- Test Case 3: 4 + 6 = 10
        A <= "0100"; -- 4
        B <= "0110"; -- 6
        SUB <= '0';
        WAIT FOR 10 ns;

        -- Test Case 4: 6 - 9 = -3 (2's complement = 1101)
        A <= "0110"; -- 6
        B <= "1001"; -- 9
        SUB <= '1';
        WAIT FOR 10 ns;

        WAIT;
    END PROCESS;

END Behavioral;