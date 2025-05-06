----------------------------------------------------------------------------------
-- Company: CSE_UOM
-- Engineer: Sheneth Fernando
-- Create Date: 05/04/2025 08:27:12 PM
-- Module Name: TB_mux2x1_4Bit - Behavioral

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_mux2x1_4Bit is
--  Port ( );
end TB_mux2x1_4Bit;

architecture Behavioral of TB_mux2x1_4Bit is

component Mux_4bit_2way
    Port (
        A   : in  STD_LOGIC_VECTOR(3 downto 0);
        B   : in  STD_LOGIC_VECTOR(3 downto 0);
        sel : in  STD_LOGIC;
        en  : in  STD_LOGIC;
        Y   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end component;

signal A, B, Y : STD_LOGIC_VECTOR(3 downto 0);
signal sel, en : STD_LOGIC;

begin
    UUT: Mux_4bit_2way
    port map (
        A   => A,
        B   => B,
        sel => sel,
        en  => en,
        Y   => Y
    );
    
    Process
    Begin
        --Test Case(01)|Selecting A [ A:='0101' B:='1110' sel:=0 en:=1 (output should be A, which is 0001)];
        A <= "0101";
        B <= "1110";
        sel <= '0';
        en <= '1';
        wait for 100ns;
        
        --Test Case(02)|Selecting B [ A:='0101' B:='1110' sel:=1 en:=1 (output should be B, which is 1110)];
        sel <= '1';
        wait for 100ns;
      
        --Test Case(03)|Check Enable Signal [ A:='0101' B:='1110' sel:=1 en:=0 (output should be 0000)];
        en <= '0';
        wait for 100ns;
        
        -- Test Case(04)|New Inputs,Check MUX again [A:='1101' B:='1001' sel:=0 en:=1 (output should be A, which is 1101)]
        A   <= "1101"; 
        B   <= "1001"; 
        en  <= '1'; 
        sel <= '0';
        wait for 100 ns;
        
       -- Test Case(05)|New Inputs,Check MUX again [A:='1101' B:='1001' sel:=1 en:=1 (output should be B, which is 1001)]
        sel <= '1';
        wait for 100 ns;
        wait;
        
        end process;

end Behavioral;
