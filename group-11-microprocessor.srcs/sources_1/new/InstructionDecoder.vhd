LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_MISC.OR_REDUCE;

ENTITY InstructionDecoder IS
    PORT (
        INSTRUCTION_IN : IN STD_LOGIC_VECTOR (11 DOWNTO 0); -- Input for the 12 bit instruction
        REG_CHK_JMP : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- get the value stored in REG_A and then use it to execute JZR instruction

        ADD_SUB_SEL : OUT STD_LOGIC; -- 0 for ADD, 1 for SUB
        REG_EN : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- Enable the input port of a given register in register bank
        REG_SEL_A : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3 bits address to select REG_A
        REG_SEL_B : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3 bits address to select REG_B
        IMMEDIATE_VAL : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- Value to be stored in a register (given by the instruction)
        LOAD_SEL : OUT STD_LOGIC; -- select which data to load, from RCA or from Immediate value; 0 for RCA, 1 for Immediate
        JMP_FLAG : OUT STD_LOGIC; -- 0 for no jump, 1 for jump
        JMP_ADDR : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) -- address for jump
    );
END InstructionDecoder;

ARCHITECTURE Behavioral OF InstructionDecoder IS
    COMPONENT Decoder_2to4
        PORT (
            I : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
            EN : IN STD_LOGIC;
            Y : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
    END COMPONENT;

    SIGNAL INSTRUCTION_CODE : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL INSTRUCTION_DECODED : STD_LOGIC_VECTOR(3 DOWNTO 0);

    SIGNAL R_A, R_B : STD_LOGIC_VECTOR(2 DOWNTO 0); -- Register addresses
    SIGNAL D : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Immediate value (can be 3 bits to 4 bits long)

    SIGNAL IS_MOVI, IS_ADD, IS_NEG, IS_JZR : STD_LOGIC;

BEGIN
    INSTRUCTION_CODE <= INSTRUCTION_IN(11 DOWNTO 10); -- first two bits represent the instruction opcode (ie: bits are indexed from right-0 to left-11)
    R_A <= INSTRUCTION_IN(9 DOWNTO 7); -- next 3 bits represent register A address
    R_B <= INSTRUCTION_IN(6 DOWNTO 4); -- next 3 bits represetn register B address
    D <= INSTRUCTION_IN(3 DOWNTO 0); -- next 4 bits represent immediate value for (MOVI) or jump address for (JZR)

    Decoder_2_4_0 : Decoder_2to4
    PORT MAP(
        I => INSTRUCTION_CODE,
        EN => '1',
        Y => INSTRUCTION_DECODED
    );

    IS_MOVI <= INSTRUCTION_DECODED(2);
    IS_ADD <= INSTRUCTION_DECODED(0);
    IS_NEG <= INSTRUCTION_DECODED(1);
    IS_JZR <= INSTRUCTION_DECODED(3);

    PROCESS (IS_MOVI, IS_ADD, IS_NEG, IS_JZR, R_A, R_B, D, REG_CHK_JMP)
    BEGIN
        -- Default outputs
        ADD_SUB_SEL <= '0';
        REG_EN <= (OTHERS => '0');
        REG_SEL_A <= (OTHERS => '0');
        REG_SEL_B <= (OTHERS => '0');
        IMMEDIATE_VAL <= (OTHERS => '0');
        LOAD_SEL <= '0';
        JMP_FLAG <= '0';
        JMP_ADDR <= (OTHERS => '0');

        IF IS_MOVI = '1' THEN
            -- MOVI
            REG_EN <= R_A; -- Enable the first register for write
            LOAD_SEL <= '1'; -- set load source to immediate value
            IMMEDIATE_VAL <= D; -- set immediate value from instruction

        ELSIF IS_ADD = '1' THEN
            -- ADD
            REG_SEL_A <= R_A; -- set first register as the first input of RCA
            REG_SEL_B <= R_B; -- set second register as second input of RCA
            REG_EN <= R_A; -- enable first register for write
            ADD_SUB_SEL <= '0'; -- set ADD mode
            LOAD_SEL <= '0'; -- set load source to RCA

        ELSIF IS_NEG = '1' THEN
            -- NEG
            REG_SEL_A <= "000"; -- set 0 as the first input of RCA
            REG_SEL_B <= R_B; -- set second register as second input of RCA
            REG_EN <= R_A; -- enable first register for write
            ADD_SUB_SEL <= '1'; -- set SUBTRACT mode
            LOAD_SEL <= '0'; -- set load source to RCA

        ELSIF IS_JZR = '1' THEN
            -- JZR
            REG_SEL_A <= R_A; -- set first register as the REG_CHK
            JMP_ADDR <= D(2 DOWNTO 0); -- SET JMP address
            JMP_FLAG <= NOT(OR_REDUCE(REG_CHK_JMP)); -- set JMP flag to 1 if REG_CHK is 0000
        END IF;
    END PROCESS;

END Behavioral;