----------------------------------------------------------------------------------
-- Engineer: Sahithyan K.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC_3bit is
    Port (
        Clk        : in std_logic;
        Reset      : in std_logic;
        Enable     : in std_logic;
        Load       : in std_logic;
        Load_value : in std_logic_vector(2 downto 0);
        PC_out     : out std_logic_vector(2 downto 0)
    );
end PC_3bit;

architecture Behavioral of PC_3bit is

signal PC : unsigned(2 downto 0) := (others => '0');

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if Reset = '1' then
                PC <= (others => '0');
            elsif Load = '1' then
                PC <= unsigned(Load_value);
            elsif Enable = '1' then
                PC <= PC + 1;
            end if;
        end if;
    end process;
    
    PC_out <= std_logic_vector(PC);

end Behavioral;
