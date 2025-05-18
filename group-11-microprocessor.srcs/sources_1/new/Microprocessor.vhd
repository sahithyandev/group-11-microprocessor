LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Microprocessor IS
    PORT (
        Clk : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Data : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        Overflow : OUT STD_LOGIC;
        Zero : OUT STD_LOGIC;
        Seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
END Microprocessor;

ARCHITECTURE Behavioral OF Microprocessor IS

    COMPONENT RegisterBank
        PORT (
            Clk : IN STD_LOGIC;
            Reset : IN STD_LOGIC;

            REG_SEL : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            REG_IN : IN STD_LOGIC_VECTOR (3 DOWNTO 0);

            REG_OUT0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            REG_OUT1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            REG_OUT2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            REG_OUT3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            REG_OUT4 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            REG_OUT5 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            REG_OUT6 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            REG_OUT7 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;
    COMPONENT Mux_4bit_8way
        PORT (
            D0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D3 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D4 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D5 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D6 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D7 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            sel : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Y : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
    END COMPONENT;

    COMPONENT RCASubtractor_4bit
        PORT (
            A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            SUB : IN STD_LOGIC;
            S : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            Overflow : OUT STD_LOGIC;
            Zero : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT Mux_4bit_2way
        PORT (
            A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            sel : IN STD_LOGIC;
            Y : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
    END COMPONENT;

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
    COMPONENT PC_3bit
        PORT (
            Clk : IN STD_LOGIC;
            Reset : IN STD_LOGIC;
            Load_value : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            PC_out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Adder_3bit
        PORT (
            PC : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            Next_PC : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Mux_3bit_2way
        PORT (
            A : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            S : IN STD_LOGIC;
            Y : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
    END COMPONENT;

    COMPONENT ROM
        PORT (
            address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            instruction : OUT STD_LOGIC_VECTOR (11 DOWNTO 0));
    END COMPONENT;

    COMPONENT SevenSeg_ROM
        PORT (
            address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            data : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
    END COMPONENT;

    -- Signals from RegisterBank
    SIGNAL reg_out0, reg_out1, reg_out2, reg_out3 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL reg_out4, reg_out5, reg_out6, reg_out7 : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Signals from Mux_4bit_8way
    SIGNAL mux8_out_A : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL mux8_out_B : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Signals from Mux_4bit_2way
    SIGNAL mux2_out : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Signals from RCASubtractor_4bit
    SIGNAL subtract_out : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL overflow_flag : STD_LOGIC;

    -- Signals from PC_3bit
    SIGNAL pc_out : STD_LOGIC_VECTOR(2 DOWNTO 0);

    -- Signals from Adder_3bit
    SIGNAL next_pc : STD_LOGIC_VECTOR(2 DOWNTO 0);

    -- Signals from InstructionDecoder
    SIGNAL reg_en, reg_sel_a, reg_sel_b : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL immediate_val : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL add_sub_sel, load_sel : STD_LOGIC;
    SIGNAL jmp_flag : STD_LOGIC;
    SIGNAL jmp_addr : STD_LOGIC_VECTOR(2 DOWNTO 0);

    -- Signals from ROM
    SIGNAL instr : STD_LOGIC_VECTOR(11 DOWNTO 0);

    -- Signals from Mux_3bit_2way
    SIGNAL mux2_3_out : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN

    -- Program Counter
    PC : PC_3bit
    PORT MAP(
        Clk => Clk,
        Reset => Reset,
        Load_value => mux2_3_out,
        PC_out => pc_out
    );

    -- Adder for next PC
    ADDER_3 : Adder_3bit
    PORT MAP(
        PC => pc_out,
        Next_PC => next_pc
    );

    -- Mux to select between next PC or jump address
    PC_JMP_MUX : Mux_3bit_2way
    PORT MAP(
        A => next_pc,
        B => jmp_addr,
        S => jmp_flag,
        Y => mux2_3_out
    );

    -- ROM for instruction fetch
    PROG_ROM : ROM
    PORT MAP(
        address => pc_out,
        instruction => instr
    );

    -- Instruction Decoder
    DECODER : InstructionDecoder
    PORT MAP(
        INSTRUCTION_IN => instr,
        REG_CHK_JMP => mux8_out_A,
        ADD_SUB_SEL => add_sub_sel,
        REG_EN => reg_en,
        REG_SEL_A => reg_sel_a,
        REG_SEL_B => reg_sel_b,
        IMMEDIATE_VAL => immediate_val,
        LOAD_SEL => load_sel,
        JMP_FLAG => jmp_flag,
        JMP_ADDR => jmp_addr
    );

    -- Register Bank
    REG_BANK : RegisterBank
    PORT MAP(
        Clk => Clk,
        Reset => Reset,
        REG_SEL => reg_en,
        REG_IN => mux2_out,
        REG_OUT0 => reg_out0,
        REG_OUT1 => reg_out1,
        REG_OUT2 => reg_out2,
        REG_OUT3 => reg_out3,
        REG_OUT4 => reg_out4,
        REG_OUT5 => reg_out5,
        REG_OUT6 => reg_out6,
        REG_OUT7 => reg_out7
    );

    -- Mux to select register A
    REG_SEL_MUX_A : Mux_4bit_8way
    PORT MAP(
        D0 => reg_out0,
        D1 => reg_out1,
        D2 => reg_out2,
        D3 => reg_out3,
        D4 => reg_out4,
        D5 => reg_out5,
        D6 => reg_out6,
        D7 => reg_out7,
        sel => reg_sel_a,
        Y => mux8_out_A
    );
    -- Mux to select register B
    REG_SEL_MUX_B : Mux_4bit_8way
    PORT MAP(
        D0 => reg_out0,
        D1 => reg_out1,
        D2 => reg_out2,
        D3 => reg_out3,
        D4 => reg_out4,
        D5 => reg_out5,
        D6 => reg_out6,
        D7 => reg_out7,
        sel => reg_sel_b,
        Y => mux8_out_B
    );

    -- Mux to select between subtract out or immediate
    IMMEDIATE_SEL_MUX : Mux_4bit_2way
    PORT MAP(
        A => subtract_out, -- or selected reg_outB, adjust if needed
        B => immediate_val,
        sel => load_sel,
        Y => mux2_out
    );

    -- Subtractor (or adder)
    SUBTRACTOR : RCASubtractor_4bit
    PORT MAP(
        A => mux8_out_A,
        B => mux8_out_B,
        SUB => add_sub_sel,
        S => subtract_out,
        Zero => Zero,
        Overflow => overflow_flag
    );

    -- Outputs
    Data <= reg_out7;
    Overflow <= overflow_flag;

    -- 7-segment display logic
    SEGMENT_DISPLAY : SevenSeg_ROM
    PORT MAP(
        address => reg_out7,
        data => Seg
    );

END Behavioral;