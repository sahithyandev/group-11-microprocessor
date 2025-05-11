library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Buffer_4bit is
end TB_Buffer_4bit;

architecture behavior of TB_Buffer_4bit is
    component Buffer_4bit
        Port (
            data_in  : in  std_logic_vector(3 downto 0);
            enable   : in  std_logic;
            data_out : out std_logic_vector(3 downto 0)
        );
    end component;

    signal data_in  : std_logic_vector(3 downto 0) := (others => '0');
    signal enable   : std_logic := '0';
    signal data_out : std_logic_vector(3 downto 0);

begin
    uut: Buffer_4bit
        port map (
            data_in  => data_in,
            enable   => enable,
            data_out => data_out
        );
    stim_proc: process
    begin
        data_in <= "1010";
        enable <= '0';
        wait for 10 ns;

        enable <= '1';
        wait for 10 ns;

        data_in <= "0101";
        wait for 10 ns;

        enable <= '0';
        wait for 10 ns;

        data_in <= "1111";
        wait for 10 ns;

        enable <= '1';
        wait for 10 ns;

        wait;
    end process;

end behavior;
