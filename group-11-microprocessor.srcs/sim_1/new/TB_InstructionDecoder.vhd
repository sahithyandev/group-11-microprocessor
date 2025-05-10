LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TB_InstructionDecoder IS
END TB_InstructionDecoder;

ARCHITECTURE behavior OF TB_InstructionDecoder IS

    -- Component under test
    COMPONENT InstructionDecoder
        PORT (
            INSTRUCTION_IN : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
            REG_CHK_JMP : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            ADD_SUB_SEL : OUT STD_LOGIC;
            REG_EN : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            REG_SEL_A : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            REG_SEL_B : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            IMMEDIATE_VAL : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            LOAD_SEL : OUT STD_LOGIC;
            JMP_FLAG : OUT STD_LOGIC;
            JMP_ADDR : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT;

    -- Signals
    SIGNAL INSTRUCTION_IN : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0');
    SIGNAL REG_CHK_JMP : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL ADD_SUB_SEL : STD_LOGIC;
    SIGNAL REG_EN : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL REG_SEL_A : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL REG_SEL_B : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL IMMEDIATE_VAL : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL LOAD_SEL : STD_LOGIC;
    SIGNAL JMP_FLAG : STD_LOGIC;
    SIGNAL JMP_ADDR : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

    -- Instantiate the unit under test
    uut : InstructionDecoder PORT MAP(
        INSTRUCTION_IN => INSTRUCTION_IN,
        REG_CHK_JMP => REG_CHK_JMP,
        ADD_SUB_SEL => ADD_SUB_SEL,
        REG_EN => REG_EN,
        REG_SEL_A => REG_SEL_A,
        REG_SEL_B => REG_SEL_B,
        IMMEDIATE_VAL => IMMEDIATE_VAL,
        LOAD_SEL => LOAD_SEL,
        JMP_FLAG => JMP_FLAG,
        JMP_ADDR => JMP_ADDR
    );

    -- Test process
    PROCESS
    BEGIN
        -- MOVI: opcode "10", R_A="001", immediate="1010"
        INSTRUCTION_IN <= "10" & "001" & "000" & "1010";
        WAIT FOR 10 ns;
        ASSERT (REG_EN = "001" AND LOAD_SEL = '1' AND IMMEDIATE_VAL = "1010")
        REPORT "MOVI test failed" SEVERITY error;

        -- ADD: opcode "00", R_A="010", R_B="011"
        INSTRUCTION_IN <= "00" & "010" & "011" & "0000";
        WAIT FOR 10 ns;
        ASSERT (REG_SEL_A = "010" AND REG_SEL_B = "011" AND REG_EN = "010" AND ADD_SUB_SEL = '0' AND LOAD_SEL = '0')
        REPORT "ADD test failed" SEVERITY error;

        -- NEG: opcode "01", R_A="100", R_B="101"
        INSTRUCTION_IN <= "01" & "100" & "101" & "0000";
        WAIT FOR 10 ns;
        ASSERT (REG_SEL_A = "000" AND REG_SEL_B = "101" AND REG_EN = "100" AND ADD_SUB_SEL = '1' AND LOAD_SEL = '0')
        REPORT "NEG test failed" SEVERITY error;

        -- JZR: opcode "11", R_A="110", jump_addr="011"
        -- REG_CHK_JMP = "0000" -> should set JMP_FLAG
        INSTRUCTION_IN <= "11" & "110" & "000" & "0011";
        REG_CHK_JMP <= "0000";
        WAIT FOR 10 ns;
        ASSERT (REG_SEL_A = "110" AND JMP_ADDR = "011" AND JMP_FLAG = '1')
        REPORT "JZR (zero) test failed" SEVERITY error;

        -- JZR: opcode "11", REG_CHK_JMP != "0000"-> should NOT set JMP_FLAG
        REG_CHK_JMP <= "0001";
        WAIT FOR 10 ns;
        ASSERT (JMP_FLAG = '0')
        REPORT "JZR (nonzero) test failed" SEVERITY error;

        REPORT "All tests passed!" SEVERITY note;
        WAIT;
    END PROCESS;

END behavior;