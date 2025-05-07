----------------------------------------------------------------------------------
-- Company: CSE_UOM
-- Engineer: Sheneth Fernando
-- Create Date: 05/04/2025 08:27:12 PM
-- Module Name: TB_mux2x1_4Bit - Behavioral

----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY TB_mux2x1_4Bit IS
    --  Port ( );
END TB_mux2x1_4Bit;

ARCHITECTURE Behavioral OF TB_mux2x1_4Bit IS

    COMPONENT Mux_4bit_2way
        PORT (
            A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            sel : IN STD_LOGIC;
            en : IN STD_LOGIC;
            Y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL A, B, Y : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL sel, en : STD_LOGIC;

BEGIN
    UUT : Mux_4bit_2way
    PORT MAP(
        A => A,
        B => B,
        sel => sel,
        en => en,
        Y => Y
    );

    PROCESS
    BEGIN
        --Test Case(01)|Selecting A [ A:='0101' B:='1110' sel:=0 en:=1 (output should be A, which is 0001)];
        A <= "0101";
        B <= "1110";
        sel <= '0';
        en <= '1';
        WAIT FOR 100 ns;

        --Test Case(02)|Selecting B [ A:='0101' B:='1110' sel:=1 en:=1 (output should be B, which is 1110)];
        sel <= '1';
        WAIT FOR 100 ns;

        --Test Case(03)|Check Enable Signal [ A:='0101' B:='1110' sel:=1 en:=0 (output should be 0000)];
        en <= '0';
        WAIT FOR 100 ns;

        -- Test Case(04)|New Inputs,Check MUX again [A:='1101' B:='1001' sel:=0 en:=1 (output should be A, which is 1101)]
        A <= "1101";
        B <= "1001";
        en <= '1';
        sel <= '0';
        WAIT FOR 100 ns;

        -- Test Case(05)|New Inputs,Check MUX again [A:='1101' B:='1001' sel:=1 en:=1 (output should be B, which is 1001)]
        sel <= '1';
        WAIT FOR 100 ns;
        WAIT;

    END PROCESS;

END Behavioral;