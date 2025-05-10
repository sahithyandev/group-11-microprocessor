----------------------------------------------------------------------------------
-- Engineer: Sahithyan K.
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY TB_Microprocessor IS
END TB_Microprocessor;

ARCHITECTURE behavior OF TB_Microprocessor IS

    -- Component under test
    COMPONENT Microprocessor
        PORT(
            Clk : IN STD_LOGIC;
            Reset : IN STD_LOGIC;
            Data : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            Overflow : OUT STD_LOGIC;
            Zero : OUT STD_LOGIC;
            Seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
        );
    END COMPONENT;

    -- Testbench signals
    SIGNAL Clk_tb : STD_LOGIC := '0';
    SIGNAL Reset_tb : STD_LOGIC := '0';
    SIGNAL Data_tb : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL Overflow_tb : STD_LOGIC;
    SIGNAL Zero_tb : STD_LOGIC;
    SIGNAL Seg_tb : STD_LOGIC_VECTOR (6 DOWNTO 0);

    -- Clock period
    CONSTANT clk_period : TIME := 20 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    UUT: Microprocessor
    PORT MAP (
        Clk => Clk_tb,
        Reset => Reset_tb,
        Data => Data_tb,
        Overflow => Overflow_tb,
        Zero => Zero_tb,
        Seg => Seg_tb
    );

    -- Clock process
    clk_process : PROCESS
    BEGIN
        WHILE TRUE LOOP
            Clk_tb <= '0';
            WAIT FOR clk_period / 2;
            Clk_tb <= '1';
            WAIT FOR clk_period / 2;
        END LOOP;
    END PROCESS;

    -- Stimulus process
    stim_proc: PROCESS
    BEGIN
        -- Initial reset
        WAIT FOR 20 ns;
        Reset_tb <= '1';
        WAIT FOR 20 ns;
        Reset_tb <= '0';

        -- Let the processor run for a while (adjust depending on program size)
        WAIT FOR 500 ns;

        -- Stop simulation
        REPORT "Simulation finished.";
        WAIT;
    END PROCESS;

END behavior;
