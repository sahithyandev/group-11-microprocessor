----------------------------------------------------------------------------------
-- Engineer: Sahithyan K.
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY HalfAdder IS
    PORT (
        A : IN STD_LOGIC;
        B : IN STD_LOGIC;
        S : OUT STD_LOGIC;
        C : OUT STD_LOGIC);
END HalfAdder;

ARCHITECTURE Behavioral OF HalfAdder IS

BEGIN
    S <= A XOR B;
    C <= A AND B;

END Behavioral;