----------------------------------------------------------------------------------
-- Engineer: Sahithyan K.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Buffer_4bit is
    Port (
        data_in : in std_logic_vector(3 downto 0);
        enable: in std_logic;
        data_out : out std_logic_vector(3 downto 0));
end Buffer_4bit;

architecture Behavioral of Buffer_4bit is

begin
    process(data_in, enable)
    begin
        if enable = '1' then
            data_out <= data_in;
        else
            data_out <= (others => 'Z');
        end if;
    end process;
end Behavioral;
