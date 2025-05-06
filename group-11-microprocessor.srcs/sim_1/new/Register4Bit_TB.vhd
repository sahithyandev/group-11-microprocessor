LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Register4bit_tb IS
END Register4bit_tb;

ARCHITECTURE behavior OF Register4bit_tb IS

    COMPONENT Register_4bit
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            load : IN STD_LOGIC;
            d : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk   : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL load  : STD_LOGIC := '0';
    SIGNAL d     : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
    SIGNAL q     : STD_LOGIC_VECTOR(3 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    uut: Register_4bit PORT MAP (
        clk => clk,
        reset => reset,
        load => load,
        d => d,
        q => q
    );

    clk_process : PROCESS
    BEGIN
        WHILE TRUE LOOP
            clk <= '0';
            WAIT FOR clk_period / 2;
            clk <= '1';
            WAIT FOR clk_period / 2;
        END LOOP;
    END PROCESS;

    PROCESS
    BEGIN
        -- Initial reset
        reset <= '1';
        WAIT FOR clk_period;
        reset <= '0';
        WAIT FOR clk_period;

        -- Load 1010 into register
        d <= "1010";
        load <= '1';
        WAIT FOR clk_period;

        -- Hold value
        load <= '0';
        d <= "1111"; -- Should be ignored
        WAIT FOR clk_period;

        -- Load 0101 into register
        load <= '1';
        d <= "0101";
        WAIT FOR clk_period;

        -- Hold again
        load <= '0';
        d <= "0000"; -- Ignored again
        WAIT FOR clk_period * 2;

        -- Reset register
        reset <= '1';
        WAIT FOR clk_period;
        reset <= '0';

        WAIT FOR clk_period;

        -- Finish simulation
        WAIT;
    END PROCESS;

END behavior;
