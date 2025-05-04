LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY RegisterBank IS
    PORT (
        Clk : IN STD_LOGIC;
        Reset : IN STD_LOGIC;

        REG_SEL : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        REG_IN : IN STD_LOGIC_VECTOR (3 DOWNTO 0);

        REG_OUT0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
        REG_OUT1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
        REG_OUT2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
        REG_OUT3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
        REG_OUT4 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
        REG_OUT5 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
        REG_OUT6 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
        REG_OUT7 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000");

END RegisterBank;

ARCHITECTURE Behavioral OF RegisterBank IS

    COMPONENT Register4Bit
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            load : IN STD_LOGIC;
            d : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT DECODER_3_TO_8
        PORT (
            I : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            EN : IN STD_LOGIC;
            Y : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
    END COMPONENT;
    SIGNAL SEL : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
    Decoder : Decoder_3_to_8
    PORT MAP(
        I => REG_SEL,
        EN => '1',
        Y => SEL
    );

    REG_OUT0 <= "0000";  -- hardcoding value of R0 to 0000
    
    
    Reg1 : Register4Bit
    PORT MAP(
        D => REG_IN,
        LOAD => SEL(1),
        Clk => Clk,
        Reset => Reset,
        Q => REG_OUT1
    );

    Reg2 : Register4Bit
    PORT MAP(
        D => REG_IN,
        LOAD => SEL(2),
        Clk => Clk,
        Reset => Reset,
        Q => REG_OUT2
    );

    Reg3 : Register4Bit
    PORT MAP(
        D => REG_IN,
        LOAD => SEL(3),
        Clk => Clk,
        Reset => Reset,
        Q => REG_OUT3
    );

    Reg4 : Register4Bit
    PORT MAP(
        D => REG_IN,
        LOAD => SEL(4),
        Clk => Clk,
        Reset => Reset,
        Q => REG_OUT4
    );

    Reg5 : Register4Bit
    PORT MAP(
        D => REG_IN,
        LOAD => SEL(5),
        Clk => Clk,
        Reset => Reset,
        Q => REG_OUT5
    );

    Reg6 : Register4Bit
    PORT MAP(
        D => REG_IN,
        LOAD => SEL(6),
        Clk => Clk,
        Reset => Reset,
        Q => REG_OUT6
    );

    Reg7 : Register4Bit
    PORT MAP(
        D => REG_IN,
        LOAD => SEL(7),
        Clk => Clk,
        Reset => Reset,
        Q => REG_OUT7
    );
END Behavioral;