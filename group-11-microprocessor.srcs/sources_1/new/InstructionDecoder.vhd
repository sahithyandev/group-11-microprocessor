LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY InstructionDecoder IS
    PORT (
        INSTRUCTION_IN : IN STD_LOGIC_VECTOR (11 DOWNTO 0); -- Input for the 12 bit instruction
        REG_CHK_JMP : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- get the value stored in REG_A and then use it to execute JZR instruction

        ADD_SUB_SEL : OUT STD_LOGIC := '0'; -- 0 for ADD, 1 for SUB
        REG_EN : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) := "000"; -- Enable the input port of a given register in register bank
        REG_SEL_A : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) := "000"; -- 3 bits address to select REG_A
        REG_SEL_B : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) := "000"; -- 3 bits address to select REG_B
        IMMEDIATE_VAL : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000"; -- Value to be stored in a register (given by the instruction)
        LOAD_SEL : OUT STD_LOGIC := '0'; -- select which data to load, from RCA or from Immediate value; 0 for RCA, 1 for Immediate
        JMP_FLAG : OUT STD_LOGIC := '0'; -- 0 for no jump, 1 for jump
        JMP_ADDR : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) := "000" -- address for jump
    );
END InstructionDecoder;

ARCHITECTURE Behavioral OF InstructionDecoder IS

BEGIN
END Behavioral;
