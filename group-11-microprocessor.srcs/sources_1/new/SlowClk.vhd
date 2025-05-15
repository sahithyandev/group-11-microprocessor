----------------------------------------------------------------------------------
-- Engineer: Sahithyan K.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SlowClk is
    Port (
        clk_in : in std_logic;
        clk_out : out std_logic);
end SlowClk;

architecture Behavioral of SlowClk is

signal clk_count : unsigned(19 downto 0) := (others => '0');
signal clk_status : std_logic := '0';

begin
    process (clk_in) begin
        if (rising_edge(clk_in)) then
            clk_count <= clk_count + 1;
            if (clk_count = 999_999) then
                clk_count <= (others => '0');
                clk_status <= not(clk_status);
                clk_out <= clk_status;
            end if;
        end if;
    end process;
    
end Behavioral;