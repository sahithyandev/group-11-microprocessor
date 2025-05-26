LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Register_4bit IS
    PORT (
        clk : IN STD_LOGIC;
        load : IN STD_LOGIC;
        d : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END Register_4bit;

ARCHITECTURE Structural OF Register_4bit IS

    COMPONENT DFF
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            d : IN STD_LOGIC;
            q : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL d_internal : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL q_internal : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

    d_internal(0) <= (d(0) AND load) OR (NOT(load) AND q_internal(0));
    d_internal(1) <= (d(1) AND load) OR (NOT(load) AND q_internal(1));
    d_internal(2) <= (d(2) AND load) OR (NOT(load) AND q_internal(2));
    d_internal(3) <= (d(3) AND load) OR (NOT(load) AND q_internal(3));

    FF0 : DFF PORT MAP(clk => clk, reset => '0', d => d_internal(0), q => q_internal(0));
    FF1 : DFF PORT MAP(clk => clk, reset => '0', d => d_internal(1), q => q_internal(1));
    FF2 : DFF PORT MAP(clk => clk, reset => '0', d => d_internal(2), q => q_internal(2));
    FF3 : DFF PORT MAP(clk => clk, reset => '0', d => d_internal(3), q => q_internal(3));

    q <= q_internal;

END Structural;