----------------------------------------------------------------------------------
-- Company: CSE_UOM
-- Engineer: Sheneth Fernando
-- Create Date: 05/04/2025 09:22:30 PM
-- Module Name: Mux8x1_4Bit - Behavioral

----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Mux_4bit_8way IS
    PORT (
        D0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        D1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        D2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        D3 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        D4 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        D5 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        D6 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        D7 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        sel : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Y : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END Mux_4bit_8way;

ARCHITECTURE Behavioral OF Mux_4bit_8way IS

    TYPE data_array IS ARRAY(0 TO 7) OF STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL mux_input : data_array;
    SIGNAL selected_input : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
    -- Pack inputs into array
    mux_input(0) <= D0;
    mux_input(1) <= D1;
    mux_input(2) <= D2;
    mux_input(3) <= D3;
    mux_input(4) <= D4;
    mux_input(5) <= D5;
    mux_input(6) <= D6;
    mux_input(7) <= D7;

    selected_input <= mux_input(to_integer(unsigned(sel)));

    -- Final Output
    Y <= selected_input ;
END Behavioral;
