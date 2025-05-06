library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder_3bit is
    Port (
        PC       : in  STD_LOGIC_VECTOR(2 downto 0);
        Next_PC  : out STD_LOGIC_VECTOR(2 downto 0);
        PC_Carry : out STD_LOGIC
    );
end Adder_3bit;

architecture Behavioral of Adder_3bit is

    component FullAdder
        Port (
            A     : in  STD_LOGIC;
            B     : in  STD_LOGIC;
            C_in  : in  STD_LOGIC;
            S     : out STD_LOGIC;
            C_out : out STD_LOGIC
        );
    end component;

    signal C1, C2 : STD_LOGIC;

begin

    -- Bit 0: PC(0) + 1
    FA0: FullAdder port map (
        A     => PC(0),
        B     => '1',
        C_in  => '0',
        S     => Next_PC(0),
        C_out => C1
    );

    -- Bit 1: PC(1) + carry from bit 0
    FA1: FullAdder port map (
        A     => PC(1),
        B     => '0',
        C_in  => C1,
        S     => Next_PC(1),
        C_out => C2
    );

    -- Bit 2: PC(2) + carry from bit 1
    FA2: FullAdder port map (
        A     => PC(2),
        B     => '0',
        C_in  => C2,
        S     => Next_PC(2),
        C_out => PC_Carry
    );

end Behavioral;
