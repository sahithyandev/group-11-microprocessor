LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TB_PC_Incrementer IS
END TB_PC_Incrementer;

ARCHITECTURE Behavioral OF TB_PC_Incrementer IS

    -- Component Declaration
    COMPONENT Adder_3bit
        PORT (
            PC : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3-bit input bus for PC
            Next_PC : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) -- 3-bit output bus for Next_PC
        );
    END COMPONENT;

    -- Signals to connect to PC_Incrementer
    SIGNAL PC : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    SIGNAL Next_PC : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    UUT : Adder_3bit
    PORT MAP(
        PC => PC,
        Next_PC => Next_PC
    );

    -- Stimulus Process
    stim_proc : PROCESS
    BEGIN
        -- Test 0 + 1 = 1
        PC <= "000";
        WAIT FOR 10 ns;

        -- Test 1 + 1 = 2
        PC <= "001";
        WAIT FOR 10 ns;

        -- Test 2 + 1 = 3
        PC <= "010";
        WAIT FOR 10 ns;

        -- Test 6 + 1 = 7
        PC <= "110";
        WAIT FOR 10 ns;

        -- Test 7 + 1 = 0 (Overflow, carry = 1)
        PC <= "111";
        WAIT FOR 10 ns;

        WAIT;
    END PROCESS;

END Behavioral;