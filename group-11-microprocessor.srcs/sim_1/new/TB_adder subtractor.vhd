library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Adder_Subtractor is
end TB_Adder_Subtractor;

architecture Behavioral of TB_Adder_Subtractor is

    -- Component Declaration
    component RCASubtractor_4bit
        port (
            A        : in  STD_LOGIC_VECTOR(3 downto 0);
            B        : in  STD_LOGIC_VECTOR(3 downto 0);
            SUB      : in  STD_LOGIC;
            S        : out STD_LOGIC_VECTOR(3 downto 0);
            C_out    : out STD_LOGIC;
            Overflow : out STD_LOGIC
        );
    end component;

    -- Signals for inputs and outputs
    signal A, B     : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal SUB      : STD_LOGIC := '0';
    signal S        : STD_LOGIC_VECTOR(3 downto 0);
    signal C_out    : STD_LOGIC;
    signal Overflow : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: RCASubtractor_4bit
        port map (
            A        => A,
            B        => B,
            SUB      => SUB,
            S        => S,
            C_out    => C_out,
            Overflow => Overflow
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test Case 1: 5 + 3 = 8
        A <= "0101";  -- 5
        B <= "0011";  -- 3
        SUB <= '0';   -- Addition
        wait for 10 ns;

        -- Test Case 2: 7 - 2 = 5
        A <= "0111";  -- 7
        B <= "0010";  -- 2
        SUB <= '1';   -- Subtraction
        wait for 10 ns;

        -- Test Case 3: 4 + 6 = 10
        A <= "0100";  -- 4
        B <= "0110";  -- 6
        SUB <= '0';
        wait for 10 ns;

        -- Test Case 4: 6 - 9 = -3 (2's complement = 1101)
        A <= "0110";  -- 6
        B <= "1001";  -- 9
        SUB <= '1';
        wait for 10 ns;

        wait;
    end process;

end Behavioral;
