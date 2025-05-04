----------------------------------------------------------------------------------
-- Engineer: Sahithyan K.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_2way_3bit is
    port (
        A : in std_logic_vector(2 downto 0);
        B : in std_logic_vector(2 downto 0);
        S : in std_logic;
        Y : out std_logic_vector(2 downto 0));
end MUX_2way_3bit;

architecture Behavioral of MUX_2way_3bit is

begin
    process (A,B,S)
    begin
        if S = '0' then
            Y <= A;
        else
            Y <= B;
        end if;
    end process;
end Behavioral;
