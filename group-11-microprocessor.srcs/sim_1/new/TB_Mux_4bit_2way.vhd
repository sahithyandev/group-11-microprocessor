----------------------------------------------------------------------------------
-- Company: CSE_UOM
-- Engineer: Sheneth Fernando
-- Create Date: 05/04/2025 08:27:12 PM
-- Module Name: TB_mux2x1_4Bit - Behavioral

----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY TB_Mux_4bit_2way IS
    --  Port ( );
END TB_Mux_4bit_2way;

ARCHITECTURE Behavioral OF TB_Mux_4bit_2way IS

    COMPONENT Mux_4bit_2way
        PORT (
            A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            sel : IN STD_LOGIC;
            Y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL A, B, Y : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL sel : STD_LOGIC;

BEGIN
    UUT : Mux_4bit_2way
    PORT MAP(
        A => A,
        B => B,
        sel => sel,
        Y => Y
    );

    Process
    Begin
        --Test Case(01)|Selecting A [ A:='0101' B:='1110' sel:=0  (output should be A, which is 0101)];
        A <= "0101";
        B <= "1110";
        sel <= '0';
        wait for 100 ns;
        
        --Test Case(02)|Selecting B [ A:='0101' B:='1110' sel:=1  (output should be B, which is 1110)];
        sel <= '1';
        wait for 100 ns;
          
        -- Test Case(03)|New Inputs,Check MUX again [A:='1101' B:='1001' sel:=0  (output should be A, which is 1101)]
        A   <= "1101"; 
        B   <= "1001"; 
        sel <= '0';
        wait for 100 ns;
        
       -- Test Case(04)|New Inputs,Check MUX again [A:='1101' B:='1001' sel:=1 (output should be B, which is 1001)]
        sel <= '1';
        wait for 100 ns;
        wait;
        
    End Process;

END Behavioral;
