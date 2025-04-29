LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY RCA_4 IS
    PORT (
        A0 : IN STD_LOGIC;
        A1 : IN STD_LOGIC;
        A2 : IN STD_LOGIC;
        A3 : IN STD_LOGIC;
        B0 : IN STD_LOGIC;
        B1 : IN STD_LOGIC;
        B2 : IN STD_LOGIC;
        B3 : IN STD_LOGIC;
        -- C_in : in STD_LOGIC;
        S0 : OUT STD_LOGIC;
        S1 : OUT STD_LOGIC;
        S2 : OUT STD_LOGIC;
        S3 : OUT STD_LOGIC;
        C_out : OUT STD_LOGIC);
END RCA_4;

ARCHITECTURE Behavioral OF RCA_4 IS

    COMPONENT FA
        PORT (
            A : IN STD_LOGIC;
            B : IN STD_LOGIC;
            C_in : IN STD_LOGIC;
            S : OUT STD_LOGIC;
            C_out : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL FA0_S, FA0_C, FA1_S, FA1_C, FA2_S, FA2_C, FA3_S, FA3_C : STD_LOGIC;

BEGIN

    FA_0 : FA
    PORT MAP(
        A => A0,
        B => B0,
        C_in => '0',
        S => S0,
        C_Out => FA0_C);

    FA_1 : FA
    PORT MAP(
        A => A1,
        B => B1,
        C_in => FA0_C,
        S => S1,
        C_Out => FA1_C);

    FA_2 : FA
    PORT MAP(
        A => A2,
        B => B2,
        C_in => FA1_C,
        S => S2,
        C_Out => FA2_C);

    FA_3 : FA
    PORT MAP(
        A => A3,
        B => B3,
        C_in => FA2_C,
        S => S3,
        C_Out => C_out);

END Behavioral;