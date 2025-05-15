---------------------------------------------------------------------------------- 
-- Engineer: Sahithyan K.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SlowClockedMicroprocessor is
    PORT (
        Clk : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Data : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        Overflow : OUT STD_LOGIC;
        Zero : OUT STD_LOGIC;
        Seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
end SlowClockedMicroprocessor;

architecture Behavioral of SlowClockedMicroprocessor is
    
    component Microprocessor IS
        PORT (
            Clk : IN STD_LOGIC;
            Reset : IN STD_LOGIC;
            Data : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            Overflow : OUT STD_LOGIC;
            Zero : OUT STD_LOGIC;
            Seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
    END component;
    
    component SlowClk is
        Port (
            clk_in : in std_logic;
            clk_out : out std_logic);
    end component;
    
    signal slow_clk: std_logic;

begin
    SlowedClock : SlowClk
        port map (
            clk_in => Clk,
            clk_out => slow_clk
        );
        
    Core : Microprocessor
        port map (
            Clk => slow_clk,
            Reset => Reset,
            Data => Data,
            Overflow => Overflow,
            Zero => Zero,
            Seg => Seg            
        );
end Behavioral;
