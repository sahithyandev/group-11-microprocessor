library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_PC_Incrementer is
end TB_PC_Incrementer;

architecture Behavioral of TB_PC_Incrementer is

    -- Component Declaration
    component PC_Incrementer
        Port (
            PC     : in  STD_LOGIC_VECTOR(2 downto 0);  -- 3-bit input bus for PC
            Next_PC : out STD_LOGIC_VECTOR(2 downto 0);  -- 3-bit output bus for Next_PC
            PC_Carry : out STD_LOGIC                      -- Carry output
        );
    end component;

    -- Signals to connect to PC_Incrementer
    signal PC : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal Next_PC : STD_LOGIC_VECTOR(2 downto 0);
    signal PC_Carry : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: PC_Incrementer
        port map (
            PC => PC,
            Next_PC => Next_PC,
            PC_Carry => PC_Carry
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test 0 + 1 = 1
        PC <= "000";
        wait for 10 ns;

        -- Test 1 + 1 = 2
        PC <= "001";
        wait for 10 ns;

        -- Test 2 + 1 = 3
        PC <= "010";
        wait for 10 ns;

        -- Test 6 + 1 = 7
        PC <= "110";
        wait for 10 ns;

        -- Test 7 + 1 = 0 (Overflow, carry = 1)
        PC <= "111";
        wait for 10 ns;

        wait;
    end process;

end Behavioral;
