----------------------------------------------------------------------------------
-- Company: CSE_UOM
-- Engineer: Sheneth Fernando
-- Create Date: 05/04/2025 07:02:00 PM
-- Module Name: mux2x1_4Bit - Behavioral

----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY Mux_4bit_2way IS
    PORT (
        A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        sel : IN STD_LOGIC;
        Y : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END Mux_4bit_2way;

ARCHITECTURE Behavioral OF Mux_4bit_2way IS

    SIGNAL not_sel : STD_LOGIC;
    SIGNAL A_out, B_out : STD_LOGIC_VECTOR(3 DOWNTO 0);


BEGIN
    --Inverse of sel signal
    not_sel <= NOT sel;

    A_out(0) <= A(0) AND not_sel;
    A_out(1) <= A(1) AND not_sel;
    A_out(2) <= A(2) AND not_sel;
    A_out(3) <= A(3) AND not_sel;

    B_out(0) <= B(0) AND sel;
    B_out(1) <= B(1) AND sel;
    B_out(2) <= B(2) AND sel;
    B_out(3) <= B(3) AND sel;

    --Final Output 
    Y(0) <= A_out(0) or B_out(0);
    Y(1) <= A_out(1) or B_out(1);
    Y(2) <= A_out(2) or B_out(2);
    Y(3) <= A_out(3) or B_out(3);

END Behavioral;
